import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/features/dapp_info/application/dapp_info_cubit.dart';
import 'package:dappstore/features/dapp_info/application/handler/i_dapp_info_handler.dart';
import 'package:dappstore/features/dapp_info/application/i_dapp_info_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';

class DappInfoHandler implements IDappInfoHandler {
  late IDappInfoCubit _dappInfoCubit;
  DappInfoHandler() {
    _dappInfoCubit = DappInfoCubit(storeCubit: getIt<IStoreCubit>());
  }

  @override
  IThemeCubit get themeCubit => getIt<IThemeCubit>();

  @override
  IStoreCubit get storeCubit => getIt<IStoreCubit>();

  @override
  IDappInfoCubit get dappInfoCubit => _dappInfoCubit;
}
