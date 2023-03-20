part of 'permissions_cubit.dart';

@freezed
class PermissionsState with _$PermissionsState {
  const factory PermissionsState({
    PermissionStatus? storagePermission,
  }) = _PermissionsState;

  factory PermissionsState.initial() => const PermissionsState();
}
