import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/constants/routes.dart';
import 'package:dappstore/core/router/interface/route.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/core/theme/theme_cubit.dart';
import 'package:dappstore/features/dapp_info/application/dapp_info_cubit.dart';
import 'package:dappstore/features/dapp_info/application/handler/dapp_info_handler.dart';
import 'package:dappstore/features/dapp_info/application/handler/i_dapp_info_handler.dart';
import 'package:dappstore/features/dapp_info/application/i_dapp_info_cubit.dart';
import 'package:dappstore/features/dapp_info/presentation/widgets/add_rating_card.dart';
import 'package:dappstore/features/dapp_info/presentation/widgets/app_stats_card.dart';
import 'package:dappstore/features/dapp_info/presentation/widgets/dapp_title_tile.dart';
import 'package:dappstore/features/dapp_info/presentation/widgets/dashed_line.dart';
import 'package:dappstore/features/dapp_info/presentation/widgets/description_box.dart';
import 'package:dappstore/features/dapp_info/presentation/widgets/image_carousel.dart';
import 'package:dappstore/features/dapp_info/presentation/widgets/similar_apps.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_query_dto.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/in_screen_appbar.dart';
import 'package:dappstore/widgets/cards/default_card.dart';
import 'package:dappstore/widgets/snacbar/snacbar_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class DappInfoPage extends StatefulScreen {
  const DappInfoPage({super.key});

  @override
  State<DappInfoPage> createState() => _DappInfoPageState();

  @override
  String get route => Routes.dappInfo;
}

class _DappInfoPageState extends State<DappInfoPage> {
  late final IDappInfoHandler dappInfoHandler;
  late final IThemeCubit themeCubit;
  late Widget dashedLine;
  @override
  void initState() {
    super.initState();
    dappInfoHandler = DappInfoHandler();
    themeCubit = dappInfoHandler.themeCubit;
    dashedLine = DashedLine(
      color: dappInfoHandler.themeCubit.theme.whiteColor,
      space: 10,
      width: 30,
      padding: 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IThemeCubit, ThemeState>(
      bloc: themeCubit,
      builder: (context, state) {
        final theme = state.activeTheme!;
        return BlocBuilder<IDappInfoCubit, DappInfoState>(
            bloc: dappInfoHandler.dappInfoCubit,
            builder: (context, dappState) {
              final storeHandler = DappStoreHandler();
              storeHandler.getSelectedCategoryDappList(
                  queryParams: GetDappQueryDto(
                      categories: [dappState.dappInfo?.category]));
              return Scaffold(
                backgroundColor: theme.backgroundColor,
                appBar: InScreenAppBar(
                  themeSpec: theme,
                  actions: const [],
                ),
                body: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        10,
                        32.0,
                        10,
                        12,
                      ),
                      child: ImageCarousel(
                        imageUrls:
                            (dappState.dappInfo?.images?.screenshots ?? []),
                        dappInfoHandler: dappInfoHandler,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 45),
                      child: DappTitleTile(
                        dappInfo: dappState.dappInfo!,
                        theme: theme,
                        primaryTile: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: dashedLine,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child:
                          AppDescriptionBox(dappInfoHandler: dappInfoHandler),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 11.0),
                      child: AppStatsCard(
                        dappInfoHandler: dappInfoHandler,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: AddRatingCard(
                        theme: theme,
                        callback: (rating) {
                          //todo: implement this.
                        },
                      ),
                    ),
                    DefaultCard(
                      theme: theme,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              context.getLocale!.contactSupport,
                              style: theme.whiteBoldTextStyle,
                            ),
                            InkWell(
                                onTap: () {
                                  if (dappState.dappInfo?.developer?.support
                                          ?.email !=
                                      null) {
                                    canLaunchUrl(
                                      Uri.parse(
                                          "mailto://${dappState.dappInfo?.developer?.support?.email}"),
                                    );
                                  } else {
                                    context.showMsgBar(
                                        context.getLocale!.noContactInfo);
                                  }
                                },
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: theme.whiteColor,
                                ))
                          ],
                        ),
                      ),
                    ),
                    BlocBuilder<IStoreCubit, StoreState>(
                        buildWhen: (previous, current) =>
                            previous.selectedCategoryDappList.hashCode !=
                            current.selectedCategoryDappList.hashCode,
                        bloc: storeHandler.getStoreCubit(),
                        builder: (context, dappState) {
                          return SimilarApps(
                            theme: theme,
                            dappList:
                                dappState.selectedCategoryDappList?.response,
                          );
                        }),
                  ],
                ),
              );
            });
      },
    );
  }
}
