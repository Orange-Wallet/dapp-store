part of 'self_update_cubit.dart';

@freezed
class SelfUpdateState with _$SelfUpdateState {
  const factory SelfUpdateState({
    required String? url,
    required String? latestVersion,
    required String? minimumSupportedVersion,
    String? currentAppVersion,
  }) = _SelfUpdateState;

  factory SelfUpdateState.initial() => const SelfUpdateState(
      url: null,
      latestVersion: null,
      minimumSupportedVersion: null,
      currentAppVersion: null);

  factory SelfUpdateState.fromJson(Map<String, dynamic> json) =>
      _$SelfUpdateStateFromJson(json);
}
