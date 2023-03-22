import 'dart:io';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/dtos/task_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:path_provider/path_provider.dart';

typedef DownloadCallBackType = void Function(
    String id, DownloadTaskStatus status, int progress);

class Downloader {
  static IErrorLogger errorLogger = getIt<IErrorLogger>();
  static initialize(DownloadCallBackType downloadCallback) async {
    await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
    FlutterDownloader.registerCallback(downloadCallback, step: 1);
  }

  static Future<bool> initializeStorageDir(
      bool? isStorageInitialized, String saveDir) async {
    try {
      await prepareSaveDir(saveDir);
      return true;
    } catch (e) {
      errorLogger.logError(e);

      return false;
    }
  }

  static Future<TaskInfo?> requestDownload(
      TaskInfo task, bool isStorageInitialized, String localPath) async {
    try {
      final taskId = await FlutterDownloader.enqueue(
        url: task.link!,
        headers: {'auth': 'test_for_sql_encoding'},
        savedDir: localPath,
        saveInPublicStorage: true,
      );
      return task.copyWith(taskId: taskId);
    } catch (e) {
      errorLogger.logError(e);

      return null;
    }
  }

  static Future<bool> pauseDownload(TaskInfo task) async {
    try {
      await FlutterDownloader.pause(taskId: task.taskId!);
      return true;
    } catch (e) {
      errorLogger.logError(e);

      return false;
    }
  }

  static Future<bool> resumeDownload(TaskInfo task) async {
    try {
      await FlutterDownloader.resume(taskId: task.taskId!);
      return true;
    } catch (e) {
      errorLogger.logError(e);

      return false;
    }
  }

  static Future<bool> retryDownload(TaskInfo task) async {
    try {
      await FlutterDownloader.retry(taskId: task.taskId!);
      return true;
    } catch (e) {
      errorLogger.logError(e);

      return false;
    }
  }

  static Future<bool> openDownloadedFile(TaskInfo? task) async {
    try {
      final taskId = task?.taskId;
      if (taskId == null) {
        return false;
      }
      return FlutterDownloader.open(taskId: taskId);
    } catch (e) {
      errorLogger.logError(e);

      return false;
    }
  }

  static Future<bool> delete(TaskInfo task) async {
    try {
      await FlutterDownloader.remove(
        taskId: task.taskId!,
        shouldDeleteContent: true,
      );
      return true;
    } catch (e) {
      errorLogger.logError(e);

      return false;
    }
  }

  static Future<Map<String, TaskInfo>> prepare(String saveDir) async {
    try {
      final tasks = await FlutterDownloader.loadTasks();

      if (tasks == null) {
        debugPrint('No tasks were retrieved from the database.');
        return {};
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
      await prepareSaveDir(saveDir);
      return tasks_;
    } catch (e) {
      errorLogger.logError(e);

      return {};
    }
  }

  static Future<bool> prepareSaveDir(String saveDir) async {
    try {
      final localPath = saveDir;
      final savedDir = Directory(localPath);
      if (!savedDir.existsSync()) {
        await savedDir.create();
      }
      return true;
    } catch (e) {
      errorLogger.logError(e);

      return false;
    }
  }

  static Future<String?> getSavedDir() async {
    String? externalStorageDirPath;

    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (err, st) {
        errorLogger.logError(err);

        debugPrint('failed to get downloads path: $err, $st');

        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      try {
        externalStorageDirPath =
            (await getApplicationDocumentsDirectory()).absolute.path;
      } catch (err, st) {
        errorLogger.logError(err);

        debugPrint('failed to get downloads path: $err, $st');
      }
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    return externalStorageDirPath;
  }
}
