import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/router/constants/routes.dart';
import 'package:dappstore/core/router/interface/route.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/core/theme/theme_cubit.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_info/application/handler/i_dapp_info_handler.dart';
import 'package:dappstore/features/dapp_info/presentation/widgets/image_carousel.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/connect_and_explore_card.dart';
import 'package:dappstore/widgets/app_bar/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DappInforPage extends StatefulScreen {
  const DappInforPage({super.key});

  @override
  State<DappInforPage> createState() => _DappInforPageState();

  @override
  String get route => Routes.home;
}

class _DappInforPageState extends State<DappInforPage> {
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
        return Scaffold(
          backgroundColor: theme.backgroundColor,
          appBar: HomeAppbar(),
          body: ListView(
            children: [
              //ImageCarousel(imageUrls: imageUrls),
            ],
          ),
        );
      },
    );
  }
}
