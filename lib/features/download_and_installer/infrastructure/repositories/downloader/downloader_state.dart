part of 'downloader_cubit.dart';

@freezed
class DownloaderState with _$DownloaderState {
  const factory DownloaderState(
      {ReceivePort? port,
      Map<String, DownloadTask>? status,
      Map<String, TaskInfo>? tasks,
      String? localPath,
      bool? saveInPublicStorage,
      PermissionStatus? storagePermission}) = _DownloaderState;

  factory DownloaderState.initial() => DownloaderState(
        port: ReceivePort(),
        status: {},
        tasks: {},
        localPath: "",
        saveInPublicStorage: false,
      );
}
