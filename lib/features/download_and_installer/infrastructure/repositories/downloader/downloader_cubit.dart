import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:dappstore/core/permissions/i_permissions_cubit.dart';
import 'package:dappstore/core/permissions/permissions_cubit.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/dtos/task_info.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/downloader/i_downloader_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

part '../../../../../generated/features/download_and_installer/infrastructure/repositories/downloader/downloader_cubit.freezed.dart';
part 'downloader_state.dart';

@LazySingleton(as: IDownloader)
class Downloader extends Cubit<DownloaderState> implements IDownloader {
  final IPermissions permissionsCubit;
  Downloader({required this.permissionsCubit})
      : super(DownloaderState.initial());

  @override
  initialize() async {
    await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
    _bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallback, step: 1);
  }

  @override
  initializeStorageDir() async {
    final storagePerms = await _checkStorage();
    if (storagePerms && state.storageInitialized != true) {
      await _prepareSaveDir();
      emit(state.copyWith(storageInitialized: true));
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
      final taskId = await FlutterDownloader.enqueue(
        url: task.link!,
        headers: {'auth': 'test_for_sql_encoding'},
        savedDir: state.localPath!,
        saveInPublicStorage: true,
      );
      return task.copyWith(taskId: taskId);
    }
    return null;
  }

  @override
  Future<void> pauseDownload(TaskInfo task) async {
    await FlutterDownloader.pause(taskId: task.taskId!);
  }

  @override
  Future<void> resumeDownload(TaskInfo task) async {
    await FlutterDownloader.resume(taskId: task.taskId!);
  }

  @override
  Future<void> retryDownload(TaskInfo task) async {
    await FlutterDownloader.retry(taskId: task.taskId!);
  }

  @override
  Future<bool> openDownloadedFile(TaskInfo? task) async {
    final taskId = task?.taskId;
    if (taskId == null) {
      return false;
    }

    return FlutterDownloader.open(taskId: taskId);
  }

  @override
  Future<void> delete(TaskInfo task) async {
    await FlutterDownloader.remove(
      taskId: task.taskId!,
      shouldDeleteContent: true,
    );
    await _prepare();
  }

  Future<void> _prepare() async {
    final tasks = await FlutterDownloader.loadTasks();

    if (tasks == null) {
      debugPrint('No tasks were retrieved from the database.');
      return;
    }

    final Map<String, TaskInfo> tasks_ = {};

    for (final task in tasks) {
      tasks_[task.taskId] = TaskInfo(
        taskId: task.taskId,
        progress: task.progress,
        link: task.url,
        status: task.status,
        saveDir: task.savedDir,
      );
    }
    emit(state.copyWith(tasks: tasks_));
    await _prepareSaveDir();
  }

  Future<void> _prepareSaveDir() async {
    final storagePerms = await _checkStorage();

    if (storagePerms) {
      final localPath = (await _getSavedDir())!;
      final savedDir = Directory(localPath);
      if (!savedDir.existsSync()) {
        await savedDir.create();
      }
    }
  }

  Future<String?> _getSavedDir() async {
    String? externalStorageDirPath;

    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (err, st) {
        debugPrint('failed to get downloads path: $err, $st');

        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    emit(state.copyWith(localPath: externalStorageDirPath));
    return externalStorageDirPath;
  }

  Future<bool> _checkStorage() async {
    final storagePermission = await permissionsCubit.checkStoragePermission();
    return storagePermission == PermissionStatus.granted;
  }
}
