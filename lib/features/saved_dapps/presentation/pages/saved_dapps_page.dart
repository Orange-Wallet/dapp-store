import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/constants/routes.dart';
import 'package:dappstore/core/router/interface/route.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/in_screen_appbar.dart';
import 'package:dappstore/features/saved_dapps/application/handler/i_saved_dapps_handler.dart';
import 'package:dappstore/features/saved_dapps/presentation/widgets/installed_dapps_list.dart';
import 'package:flutter/material.dart';

class SavedDappsPage extends StatefulScreen {
  const SavedDappsPage({super.key});

  @override
  State<SavedDappsPage> createState() => _SavedDappsPageState();

  @override
  String get route => Routes.savedDappsPage;
}

class _SavedDappsPageState extends State<SavedDappsPage> {
  late ISavedDappsHandler handler;
  late IThemeCubit themeCubit;
  late IThemeSpec theme;

  @override
  void initState() {
    handler = getIt<ISavedDappsHandler>();
    themeCubit = getIt<IThemeCubit>();
    theme = getIt<IThemeSpec>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: InScreenAppBar(
        themeSpec: theme,
        title: context.getLocale!.manageDapps,
      ),
      body: InstalledDappsList(
        handler: handler,
      ),
    );
  }
}
