import 'dart:developer';

import 'package:dappstore/features/dapp_info/application/i_dapp_info_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_info_query_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part '../../../generated/features/dapp_info/application/dapp_info_cubit.freezed.dart';
part '../../../generated/features/dapp_info/application/dapp_info_cubit.g.dart';
part 'dapp_info_state.dart';

class DappInfoCubit extends Cubit<DappInfoState> implements IDappInfoCubit {
  final IStoreCubit storeCubit;
  DappInfoCubit({required this.storeCubit}) : super(DappInfoState.initial()) {
    final dappInfo = storeCubit.getActiveDappInfo;
    emit(state.copyWith(
        activeDappId: storeCubit.state.activeDappId,
        dappInfo: DappInfo.fromJson({
          "name": "Axie Infinity",
          "description":
              "Axie Infinity is a Pokemon-inspired digital pet universe where players use their cute characters called Axies in various games. The Axie Infinity Universe highlights the benefits of blockchain technology through \"Free to Play to Earn\" gameplay and a player-owned economy.",
          "appUrl": "https://app.aave.com/",
          "images": {
            "logo":
                "https://dashboard-assets.dappradar.com/document/9495/axieinfinity-dapp-games-ronin-logo_1ec806d57fd80ab68d351658cb8d146a.png",
            "screenshots": [
              "https://dummyimage.com/200x800.png",
              "https://dummyimage.com/200x800.png",
              "https://dummyimage.com/200x800.png",
              "https://dummyimage.com/200x800.png",
            ]
          },
          "minAge": 13,
          "isForMatureAudience": false,
          "isSelfModerated": true,
          "androidPackage": "com.trellis.OpenWallet",
          "language": "en",
          "version": "unknown",
          "isListed": true,
          "listDate": "2023-01-30",
          "availableOnPlatform": ["web", "android"],
          "category": "games",
          "chains": [1],
          "dappId": "exchange.quickswap.dapp",
          "metrics": {
            "dappId": "exchange.quickswap.dapp",
            "downloads": 0,
            "installs": 0,
            "uninstalls": 0,
            "ratingsCount": 0,
            "visits": 0,
            "rating": null
          }
        })));
    // getDappInfo(
    //     queryParams:
    //         GetDappInfoQueryDto(dappId: storeCubit.state.activeDappId));
  }

  @override
  Future<void> close() {
    return super.close();
  }

  @override
  Future<DappInfo?> getDappInfo({GetDappInfoQueryDto? queryParams}) async {
    DappInfo? dappInfo = await storeCubit.getDappInfo(queryParams: queryParams);
    log(dappInfo.toString());
    if (dappInfo != null) {
      emit(state.copyWith(dappInfo: dappInfo));
    }
    return dappInfo;
  }
}
