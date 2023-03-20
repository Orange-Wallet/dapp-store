import 'package:permission_handler/permission_handler.dart';

abstract class IPermissions {
  Future<void> checkStoragePermission();

  Future<PermissionStatus> requestStoragePermission();
}
