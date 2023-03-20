import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:dappstore/core/permissions/i_permissions_cubit.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/datasources/downloader.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/dtos/task_info.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/downloader/i_downloader_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_handler/permission_handler.dart';

part '../../../../../generated/features/download_and_installer/infrastructure/repositories/downloader/downloader_cubit.freezed.dart';
part 'downloader_state.dart';

@LazySingleton(as: IDownloader)
class DownloaderCubit extends Cubit<DownloaderState> implements IDownloader {
  final IPermissions permissionsCubit;
  DownloaderCubit({required this.permissionsCubit})
      : super(DownloaderState.initial());

  @override
  initialize() async {
    Downloader.initialize(downloadCallback);
    _bindBackgroundIsolate();
  }

  @override
  initializeStorageDir() async {
    final storagePerms = await _checkStorage();
    if (storagePerms && state.storageInitialized != true) {
      final saveDir = await Downloader.getSavedDir();
      final status = await Downloader.initializeStorageDir(
          state.storageInitialized, saveDir!);
      emit(state.copyWith(storageInitialized: status));
    }
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
    String id,
    DownloadTaskStatus status,
    int progress,
  ) {
    debugPrint(
      'Callback on background isolate: '
      'task ($id) is in status ($status) and process ($progress)',
    );

    IsolateNameServer.lookupPortByName('downloader_sendstate.port')
        ?.send([id, status, progress]);
  }

  void _bindBackgroundIsolate() {
    final isSuccess = IsolateNameServer.registerPortWithName(
      state.port!.sendPort,
      'downloader_sendstate.port!',
    );
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    state.port!.listen((dynamic data) {
      final taskId = (data as List<dynamic>)[0] as String;
      final status = DownloadTaskStatus(data[1] as int);
      final progress = data[2] as int;

      debugPrint(
        'Callback on UI isolate: '
        'task ($taskId) is in status ($status) and process ($progress)',
      );

      if (state.tasks != null && state.tasks!.isNotEmpty) {
        final task = state.tasks![taskId];
        if (task != null) {
          // ignore: unused_result
          task.copyWith(status: status, progress: progress);
          Map<String, TaskInfo> tasks = state.tasks!;
          tasks[taskId] = task;
          emit(state.copyWith(tasks: tasks));
        }
      }
    });
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_sendstate.port!');
  }

  @override
  Future<TaskInfo?> requestDownload(TaskInfo task) async {
    final storagePerms = await _checkStorage();
    debugPrint('StoragePermission: $storagePerms');
    if (storagePerms && (state.storageInitialized ?? false)) {
      final saveDir = await Downloader.getSavedDir();
      final queuedTask = await Downloader.requestDownload(
          task, state.storageInitialized ?? false, saveDir!);
      return queuedTask;
    }
    return null;
  }

  @override
  Future<void> pauseDownload(TaskInfo task) async {
    await Downloader.pauseDownload(task);
  }

  @override
  Future<void> resumeDownload(TaskInfo task) async {
    await Downloader.resumeDownload(task);
  }

  @override
  Future<void> retryDownload(TaskInfo task) async {
    await Downloader.retryDownload(task);
  }

  @override
  Future<bool> openDownloadedFile(TaskInfo? task) async {
    final taskId = task?.taskId;
    if (taskId == null) {
      return false;
    }

    return Downloader.openDownloadedFile(task);
  }

  @override
  Future<void> delete(TaskInfo task) async {
    Downloader.delete(task);
    final saveDir = await Downloader.getSavedDir();

    final Map<String, TaskInfo> tasks = await Downloader.prepare(saveDir!);
    final storagePerms = await _checkStorage();
    if (storagePerms) {
      await Downloader.prepareSaveDir(saveDir);
    }
    emit(state.copyWith(tasks: tasks));
  }

  Future<bool> _checkStorage() async {
    final storagePermission = await permissionsCubit.checkStoragePermission();
    return storagePermission == PermissionStatus.granted;
  }
}
