// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/injected_web3_cubit.dart'
    as _i3;
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/pwa_webview_cubit.dart'
    as _i4;
// ignore: depend_on_referenced_packages
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
  gh.lazySingleton<_i3.InjectedWeb3Cubit>(() => _i3.InjectedWeb3Cubit());
  gh.lazySingleton<_i4.PwaWebviewCubit>(() => _i4.PwaWebviewCubit());
  return getIt;
}
