part of 'store_cubit.dart';

@freezed
class StoreState with _$StoreState {
  const factory StoreState({
    DappList? dappList,
    DappList? searchResult,
    List<CuratedList?>? curatedList,
    int? currentPage,
    int? searchPage,
    GetDappQueryDto? searchParams,
  }) = _StoreState;

  factory StoreState.initial() => const _StoreState();

  factory StoreState.fromJson(Map<String, dynamic> json) =>
      _$StoreStateFromJson(json);
}
