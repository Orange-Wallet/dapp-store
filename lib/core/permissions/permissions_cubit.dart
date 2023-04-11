import 'dart:io';

import 'package:dappstore/core/permissions/i_permissions_cubit.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:notification_permissions/notification_permissions.dart'
    as nPerm;
import 'package:permission_handler/permission_handler.dart';

part '../../generated/core/permissions/permissions_cubit.freezed.dart';
part 'permissions_state.dart';

@LazySingleton(as: IPermissions)
class Permissions extends Cubit<PermissionsState> implements IPermissions {
  Permissions() : super(PermissionsState.initial());

  @override
  checkAllPermissions() async {
    await checkStoragePermission();
    await checkAppInstallationPermissions();
    await checkNotificationPermission();
  }

  @override
  Future<PermissionStatus> checkStoragePermission() async {
    if (Platform.isAndroid) {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      if (deviceInfo.version.sdkInt > 28) {
        emit(state.copyWith(storagePermission: PermissionStatus.granted));

        return PermissionStatus.granted;
      }
    }
    final status = await Permission.storage.status;
    emit(state.copyWith(storagePermission: status));
    return status;
  }

  @override
  Future<PermissionStatus?> checkAppInstallationPermissions() async {
    if (Platform.isAndroid) {
      final status = await Permission.requestInstallPackages.status;
      emit(state.copyWith(appInstallation: status));

      return status;
    }
    return null;
  }

  @override
  Future<PermissionStatus> checkNotificationPermission() async {
    final status = await Permission.notification.status;
    emit(state.copyWith(notificationPermission: status));
    return status;
  }

  @override
  Future<PermissionStatus> requestStoragePermission() async {
    final result = await Permission.storage.request();
    emit(state.copyWith(storagePermission: result));
    return result;
  }

  @override
  Future<PermissionStatus> requestNotificationPermission() async {
    nPerm.PermissionStatus permissionStatus =
        await nPerm.NotificationPermissions.requestNotificationPermissions();
    PermissionStatus perm = PermissionStatus.denied;
    if (permissionStatus == nPerm.PermissionStatus.granted) {
      perm = PermissionStatus.granted;
    } else if (permissionStatus == nPerm.PermissionStatus.denied) {
      perm = PermissionStatus.denied;
    } else if (permissionStatus == nPerm.PermissionStatus.provisional) {
      perm = PermissionStatus.limited;
    }
    emit(state.copyWith(notificationPermission: perm));
    return perm;
  }

  @override
  Future<PermissionStatus?> requestAppInstallationPermission() async {
    if (Platform.isAndroid) {
      final result = await Permission.requestInstallPackages.request();
      emit(state.copyWith(appInstallation: result));
      return result;
    }
    return null;
  }
}
