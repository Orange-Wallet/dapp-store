import 'dart:io';

import 'package:dappstore/core/permissions/i_permissions_cubit.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_handler/permission_handler.dart';
part '../../generated/core/permissions/permissions_cubit.freezed.dart';
part 'permissions_state.dart';

@lazySingleton
class Permissions extends Cubit<PermissionsState> implements IPermissions {
  Permissions() : super(PermissionsState.initial());
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
  Future<PermissionStatus> checkNotificationPermission() async {
    final status = await Permission.notification.status;
    emit(state.copyWith(storagePermission: status));
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
    final result = await Permission.notification.request();
    emit(state.copyWith(storagePermission: result));
    return result;
  }
}
