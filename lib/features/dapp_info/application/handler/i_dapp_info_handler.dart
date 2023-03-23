import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/repositories/i_dapp_list_repository.dart';

abstract class IDappInfoHandler {
  IThemeCubit get themeCubit;
  IDappListRepo get dappListCubit;
}
