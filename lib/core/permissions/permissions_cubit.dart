import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_handler/permission_handler.dart';
part '../../generated/core/permissions/permissions_cubit.freezed.dart';
part 'permissions_state.dart';

@lazySingleton
class Permissions extends Cubit<PermissionsState> {
  Permissions() : super(PermissionsState.initial());

  Future<void> checkStoragePermission() async {
    final status = await Permission.storage.status;
    emit(state.copyWith(storagePermission: status));
  }

  Future<PermissionStatus> requestStoragePermission() async {
    final result = await Permission.storage.request();
    emit(state.copyWith(storagePermission: result));
    return result;
  }
}
