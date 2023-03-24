part of 'store_cubit.dart';

@freezed
class StoreState with _$StoreState {
  const factory StoreState({
    DappList? dappList,
    DappList? searchResult,
    DappList? featuredDappList,
    List<CuratedCategoryList?>? curatedCategoryList,
    List<CuratedList?>? curatedList,
    Map<String, DappList?>? featuredDappsByCategory,
    int? dappListCurrentPage,
    int? searchPage,
    GetDappQueryDto? searchParams,
    String? activeDappId,
  }) = _StoreState;

  factory StoreState.initial() => const _StoreState(
        featuredDappsByCategory: {},
      );

  factory StoreState.fromJson(Map<String, dynamic> json) =>
      _$StoreStateFromJson(json);
}
