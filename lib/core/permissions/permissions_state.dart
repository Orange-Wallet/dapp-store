part of 'permissions_cubit.dart';

@freezed
class PermissionsState with _$PermissionsState {
  const factory PermissionsState({
    PermissionStatus? storagePermission,
    PermissionStatus? appInstallation,
    PermissionStatus? notificationPermission,
  }) = _PermissionsState;

  factory PermissionsState.initial() => const PermissionsState();
}
