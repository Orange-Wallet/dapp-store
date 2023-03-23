import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/features/dapp_info/application/handler/i_dapp_info_handler.dart';
import 'package:dappstore/features/dapp_store_home/domain/repositories/i_dapp_list_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IDappInfoHandler)
class DappInfoHandler implements IDappInfoHandler {
  @override
  IThemeCubit get themeCubit => getIt<IThemeCubit>();
  @override
  IDappListRepo get dappListCubit => getIt<IDappListRepo>();
}
