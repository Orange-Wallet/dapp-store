import 'dart:isolate';
import 'dart:ui';

import 'package:dappstore/core/installed_apps/i_installed_apps_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/download_and_installer/domain/package_info.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/datasources/downloader.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/dtos/task_info.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/downloader/i_downloader_cubit.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/foreground_service/i_foreground_service_cubit.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/installer/i_installer_cubit.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/i_package_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:installed_apps/app_info.dart';
part '../../../../../generated/features/download_and_installer/infrastructure/repositories/package_manager.dart/package_manager_cubit.freezed.dart';
part 'package_manager_state.dart';

@LazySingleton(as: IPackageManager)
class PackageManager extends Cubit<PackageManagerState>
    implements IPackageManager {
  final IInstallerCubit installer;
  final IDownloader downloader;
  final IForegroundService foregroundService;
  final IInstalledAppsCubit installedApps;
  PackageManager(this.installer, this.downloader, this.foregroundService,
      this.installedApps)
      : super(PackageManagerState.initial());
  @override
  init() async {
    final Future<List<DownloadTask>?> downloadsFuture =
        downloader.getAllDownloads();
    final Future<List<AppInfo>?> appInfoFuture = installedApps.getInstalledApps(
        excludeSystemApps: true, withIcon: true, packageNamePrefix: "");
    final responses = await Future.wait([downloadsFuture, appInfoFuture]);
    final List<DownloadTask>? downloads = (responses[0] as List<DownloadTask>?);
    final List<AppInfo>? appInfo = (responses[1] as List<AppInfo>?);
    Map<String, PackageInfo> packageMapping = {};
    Map<String, String> taskIdToPackageName = {};

    for (var element in appInfo!) {
      if (element.packageName != null) {
        packageMapping[element.packageName!] = PackageInfo(
          name: element.name,
          icon: element.icon,
          versionCode: element.versionCode?.toDouble() ?? 0,
          versionName: element.versionName,
          packageName: element.packageName,
          installed: true,
        );
      }
    }
    for (var dt in downloads!) {
      final packageName = _fileNameToDappId(dt.filename!);
      if (packageMapping[packageName] != null) {
        PackageInfo package = packageMapping[packageName]!;
        package = package.copyWith(
          progress: dt.progress,
          status: dt.status,
          taskId: dt.taskId,
          url: dt.url,
          fileName: dt.filename,
          saveDir: dt.savedDir,
        );
        packageMapping[packageName] = package;
      } else {
        packageMapping[packageName] = PackageInfo(
          progress: dt.progress,
          status: dt.status,
          taskId: dt.taskId,
          url: dt.url,
          fileName: dt.filename,
          saveDir: dt.savedDir,
        );
      }
      taskIdToPackageName[dt.taskId] = packageName;
    }
    emit(state.copyWith(
        packageMapping: packageMapping,
        taskIdToPackageName: taskIdToPackageName));
    _bindBackgroundIsolate();
  }

  @override
  startDownload(
    DappInfo dappInfo,
    String link,
    bool autoInstall,
  ) async {
    TaskInfo downloadRequest = TaskInfo(
        fileName: "${dappInfo.dappId}.apk", name: dappInfo.name, link: link);
    final queuedTaskInfo = await downloader.requestDownload(downloadRequest);
    if (queuedTaskInfo != null) {
      foregroundService.startForegroundService();
      PackageInfo? package =
          state.packageMapping![_fileNameToDappId(queuedTaskInfo.fileName!)];
      if (package != null) {
        package = package.copyWith(
          progress: queuedTaskInfo.progress,
          status: queuedTaskInfo.status,
          taskId: queuedTaskInfo.taskId,
          url: queuedTaskInfo.link,
          fileName: queuedTaskInfo.fileName,
          saveDir: queuedTaskInfo.saveDir,
          autoInstall: autoInstall,
        );
      } else {
        package = PackageInfo(
          progress: queuedTaskInfo.progress,
          status: queuedTaskInfo.status,
          taskId: queuedTaskInfo.taskId,
          url: queuedTaskInfo.link,
          fileName: queuedTaskInfo.fileName,
          saveDir: queuedTaskInfo.saveDir,
          autoInstall: autoInstall,
        );
        final Map<String, String> updateTaskToPackage = {
          ...state.taskIdToPackageName!
        };
        updateTaskToPackage[queuedTaskInfo.taskId!] =
            _fileNameToDappId(queuedTaskInfo.fileName!);
        final Map<String, PackageInfo> updatedMap = {...state.packageMapping!};
        updatedMap[_fileNameToDappId(queuedTaskInfo.fileName!)] = package;
        emit(state.copyWith(
            packageMapping: updatedMap,
            taskIdToPackageName: updateTaskToPackage));
      }
    }
  }

  @override
  triggerInstall(String fileName) async {
    final dappId = _fileNameToDappId(fileName);
    {
      final packageMap = state.packageMapping;
      if (packageMap![dappId] != null) {
        final package = packageMap[dappId]!.copyWith(installing: true);
        final updatedMap = {...packageMap};
        updatedMap[dappId] = package;
        emit(state.copyWith(packageMapping: updatedMap));
      }
    }
    await installer.installApp("${downloader.saveDir}/$dappId.apk");
    final packageMap = state.packageMapping;
    if (packageMap![dappId] != null) {
      final appInfo = await installedApps.getAppInfo(packageName: dappId);
      if (appInfo != null) {
        final package = packageMap[dappId]!.copyWith(installed: true);
        final updatedMap = {...packageMap};
        updatedMap[dappId] = package;
        emit(state.copyWith(packageMapping: updatedMap));
      }
    }
  }

  @override
  Future<bool?> openSettings(DappInfo dappInfo) async {
    bool? status =
        await installedApps.openSettings(packageName: dappInfo.dappId!);
    return status;
  }

  @override
  Future<bool?> openApp(DappInfo dappInfo) async {
    bool? status = await installedApps.startApp(packageName: dappInfo.dappId!);
    return status;
  }

  String _fileNameToDappId(String fileName) {
    return fileName.substring(0, fileName.length - 4);
  }

  void _bindBackgroundIsolate() {
    final isSuccess = IsolateNameServer.registerPortWithName(
      state.port!.sendPort,
      Downloader.uiCallBackPort,
    );
    if (!isSuccess) {
      _bindBackgroundIsolate();
      return;
    }
    state.port!.listen((dynamic data) async {
      debugPrint("UI data: $data");
      final taskId = (data as List<dynamic>)[0] as String;
      final status = data[1] as DownloadTaskStatus;
      final progress = data[2] as int;

      debugPrint(
        'Callback on UI isolate: '
        'task ($taskId) is in status ($status) and process ($progress)',
      );
      if (state.taskIdToPackageName != null &&
          state.taskIdToPackageName!.isNotEmpty &&
          state.packageMapping != null &&
          state.packageMapping!.isNotEmpty) {
        final packageName = state.taskIdToPackageName![taskId];
        if (packageName != null) {
          final package = state.packageMapping![packageName];
          if (package != null) {
            Map<String, PackageInfo> packages = {...state.packageMapping!};
            packages[packageName] =
                package.copyWith(status: status, progress: progress);
            emit(state.copyWith(packageMapping: packages));
            if (status == DownloadTaskStatus.complete) {
              final tasks = await downloader.getAllDownloads();
              final queue = tasks?.where((e) {
                return e.status == DownloadTaskStatus.enqueued;
              }).toList();
              if (queue?.isEmpty ?? false) {
                foregroundService.stopForegroundService();
              }
              triggerInstall("$package.apk");
            }
          }
        }
      }
    });
  }
}
