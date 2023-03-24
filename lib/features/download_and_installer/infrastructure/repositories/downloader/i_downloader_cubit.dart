import 'package:dappstore/features/download_and_installer/infrastructure/dtos/task_info.dart';

abstract class IDownloader {
  initialize();

  initializeStorageDir();

  Future<TaskInfo?> requestDownload(TaskInfo task);

  Future<void> pauseDownload(TaskInfo task);

  Future<void> resumeDownload(TaskInfo task);

  Future<void> retryDownload(TaskInfo task);

  Future<bool> openDownloadedFile(TaskInfo? task);

  Future<TaskInfo?> findById(String id);

  Future<void> addOnComplete(TaskInfo task);

  Future<void> delete(TaskInfo task);
}
