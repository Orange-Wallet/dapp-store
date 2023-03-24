import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/router/constants/routes.dart';
import 'package:dappstore/core/router/interface/route.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/core/theme/theme_cubit.dart';
import 'package:dappstore/features/dapp_info/application/handler/i_dapp_info_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/store_cubit.dart';
import 'package:dappstore/widgets/app_bar/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DappInfoPage extends StatefulScreen {
  const DappInfoPage({super.key});

  @override
  State<DappInfoPage> createState() => _DappInfoPageState();

  @override
  String get route => Routes.home;
}

class _DappInfoPageState extends State<DappInfoPage> {
  late final IDappInfoHandler dappInfoHandler;
  late final IThemeCubit themeCubit;
  @override
  void initState() {
    super.initState();
    dappInfoHandler = getIt<IDappInfoHandler>();
    themeCubit = dappInfoHandler.themeCubit;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IThemeCubit, ThemeState>(
      bloc: themeCubit,
      builder: (context, state) {
        final theme = state.activeTheme!;
        return BlocBuilder<IStoreCubit, StoreState>(
            bloc: dappInfoHandler.storeCubit,
            builder: (context, storeState) {
              return Scaffold(
                backgroundColor: theme.backgroundColor,
                appBar: HomeAppbar(),
                body: ListView(
                  children: [
                    //ImageCarousel(imageUrls: imageUrls),
                  ],
                ),
              );
            });
      },
    );
  }
}
