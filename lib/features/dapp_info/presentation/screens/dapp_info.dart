import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/router/constants/routes.dart';
import 'package:dappstore/core/router/interface/route.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/core/theme/theme_cubit.dart';
import 'package:dappstore/features/dapp_info/application/dapp_info_cubit.dart';
import 'package:dappstore/features/dapp_info/application/handler/dapp_info_handler.dart';
import 'package:dappstore/features/dapp_info/application/handler/i_dapp_info_handler.dart';
import 'package:dappstore/features/dapp_info/application/i_dapp_info_cubit.dart';
import 'package:dappstore/features/dapp_info/presentation/widgets/dapp_title_tile.dart';
import 'package:dappstore/features/dapp_info/presentation/widgets/description_box.dart';
import 'package:dappstore/features/dapp_info/presentation/widgets/image_carousel.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/home_appbar.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/in_screen_appbar.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/scaffold_with_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  @override
  void initState() {
    super.initState();
    dappInfoHandler = DappInfoHandler();
    themeCubit = dappInfoHandler.themeCubit;
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
              return ScaffoldWithBackground(
                backgroundColor: theme.backgroundColor,
                themeSpec: theme,
                appBar: InScreenAppBar(
                  themeSpec: theme,
                  actions: const [],
                ),
                body: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 32.0,
                        horizontal: 10,
                      ),
                      child: ImageCarousel(
                        imageUrls: dappState.dappInfo!.images!.screenshots!,
                        dappInfoHandler: dappInfoHandler,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: DappTitleTile(
                        dappInfoHandler: dappInfoHandler,
                      ),
                    ),
                    AppDescriptionBox(dappInfoHandler: dappInfoHandler),
                  ],
                ),
              );
            });
      },
    );
  }
}
