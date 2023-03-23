import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/features/dapp_info/application/handler/i_dapp_info_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_info_query_dto.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IDappInfoHandler)
class DappInfoHandler implements IDappInfoHandler {
  @override
  IThemeCubit get themeCubit => getIt<IThemeCubit>();
  @override
  IStoreCubit get storeCubit => getIt<IStoreCubit>();
  @override
  Future<DappInfo> dappInfo(String id) =>
      storeCubit.getDappInfo(queryParams: GetDappInfoQueryDto(dappId: id));
}
