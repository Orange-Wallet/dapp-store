part of 'self_update_cubit.dart';

@freezed
class SelfUpdateState with _$SelfUpdateState {
  const factory SelfUpdateState({
    required String? name,
    required String? address,
  }) = _SelfUpdateState;

  factory SelfUpdateState.initial() => const SelfUpdateState(
        name: null,
        address: null,
      );

  factory SelfUpdateState.fromJson(Map<String, dynamic> json) =>
      _$SelfUpdateStateFromJson(json);
}
