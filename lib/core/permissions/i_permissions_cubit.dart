import 'package:permission_handler/permission_handler.dart';

abstract class IPermissions {
  Future<PermissionStatus> checkStoragePermission();

  Future<PermissionStatus> requestStoragePermission();

  Future<PermissionStatus> checkNotificationPermission();

  Future<PermissionStatus> requestNotificationPermission();
}
