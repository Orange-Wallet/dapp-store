// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dappstore/features/dapp_store_home/application/store_cubit/store_cubit.dart'
    as _i6;
import 'package:dappstore/features/dapp_store_home/infrastructure/repositories/dapp_list_repository_impl.dart'
    as _i3;
import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/injected_web3_cubit.dart'
    as _i4;
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/pwa_webview_cubit.dart'
    as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.DappListRepoImpl>(() => _i3.DappListRepoImpl());
  gh.lazySingleton<_i4.InjectedWeb3Cubit>(() => _i4.InjectedWeb3Cubit());
  gh.lazySingleton<_i5.PwaWebviewCubit>(() => _i5.PwaWebviewCubit());
  gh.lazySingleton<_i6.StoreCubit>(
      () => _i6.StoreCubit(dappListRepo: gh<_i3.DappListRepoImpl>()));
  return getIt;
}
