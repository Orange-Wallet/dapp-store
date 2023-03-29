import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/installed_apps/i_installed_apps_cubit.dart';
import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/constants/routes.dart';
import 'package:dappstore/core/router/interface/route.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_store_home/presentation/screen/homepage.dart';
import 'package:dappstore/features/wallet_connect/presentation/widget/terms_and_condition.dart';
import 'package:dappstore/utils/constants.dart';
import 'package:dappstore/utils/image_constants.dart';
import 'package:flutter/material.dart';

class WalletConnectScreen extends StatefulScreen {
  const WalletConnectScreen({super.key});

  @override
  State<WalletConnectScreen> createState() => _WalletConnectScreenState();

  @override
  String get route => Routes.home;
}

class _WalletConnectScreenState extends State<WalletConnectScreen> {
  late final IThemeSpec theme;
  late final bool viveInstalled;
  @override
  void initState() {
    super.initState();
    theme = getIt<IThemeCubit>().theme;
  }

  @override
  void didChangeDependencies() async {
    IInstalledAppsCubit cubit = getIt<IInstalledAppsCubit>();
    cubit.getAppInfo(packageName: Constants.vivePackageName).then((value) {
      if (value != null) {
        viveInstalled = true;
      } else {
        viveInstalled = false;
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(ImageConstants.htcLogo),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 12),
                  child: Text(
                    context.getLocale!.signUpTo,
                    style: theme.headingTextStyle,
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(horizontal: 33),
                  child: TextButton(
                    onPressed: () {
                      showBottom();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: theme.whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(theme.cardRadius),
                      ),
                    ),
                    child: Text(
                      context.getLocale!.useWalletConnect,
                      style: theme.whiteButtonTextStyle,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 26, horizontal: 12),
                  child: Text(
                    context.getLocale!.dontHaveAWallet,
                    style: theme.normalTextStyle2,
                  ),
                ),
              ],
            ),
          ),
          TermsAndConditions(
            theme: theme,
          )
        ],
      ),
    );
  }

  showBottom() {
    return showModalBottomSheet(
        context: context,
        elevation: 12,
        backgroundColor: theme.backgroundCardColor,
        barrierColor: theme.backgroundCardColor.withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(theme.cardRadius),
        ),
        builder: ((context) {
          return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Text(
                    context.getLocale!.connectWallet,
                    style: theme.headingTextStyle,
                  ),
                ),
                if (viveInstalled)
                  buildViveButton(onPressed: () {}, isVive: true),
                buildViveButton(
                    onPressed: () {
                      context.popRoute();
                      context.replaceRoute(const HomePage());
                    },
                    isVive: false),
                const SizedBox(
                  height: 20,
                )
              ]);
        }));
  }

  Widget buildViveButton(
      {required void Function()? onPressed, required bool isVive}) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: theme.secondaryBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(theme.cardRadius),
          ),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 12,
            ),
            if (isVive)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(theme.imageBorderRadius),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.asset(
                  ImageConstants.viveLogo,
                ),
              ),
            if (isVive)
              const SizedBox(
                width: 12,
              ),
            Text(
              isVive
                  ? "${context.getLocale!.connectWith} VIVE Wallet"
                  : context.getLocale!.connectWithOthers,
              style: theme.normalTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
