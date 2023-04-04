import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/saved_dapps/presentation/pages/saved_dapps_page.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:dappstore/features/wallet_connect/presentation/wallet_connect_screen.dart';
import 'package:dappstore/features/wallet_connect/presentation/widget/terms_and_condition.dart';
import 'package:dappstore/utils/address_util.dart';
import 'package:dappstore/utils/icon_constants.dart';
import 'package:flutter/material.dart';

class SettingsDialog extends StatelessWidget {
  final IThemeSpec theme;
  const SettingsDialog({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "KungFu-Panda",
                    style: theme.secondaryTitleTextStyle,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    AddressUtil.getClippedAddress(getIt<IWalletConnectCubit>()
                        .getActiveAdddress()
                        .toString()),
                    style: theme.bodyTextStyle,
                  ),
                ],
              ),
              TextButton(
                  onPressed: () async {
                    await getIt<IWalletConnectCubit>().disconnectAll();
                    context.popRoute();
                    context.replaceRoute(const WalletConnectScreen());
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: theme.buttonRed,
                      ),
                      borderRadius: BorderRadius.circular(
                        theme.buttonRadius,
                      ),
                    ),
                  ),
                  child: Text(
                    context.getLocale!.logout,
                    style: theme.redButtonText,
                  )),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Divider(
            color: theme.whiteColor.withOpacity(0.08),
            height: 1,
          ),
          buildTile(
              iconAsset: IconConstants.categoryIcon,
              text: context.getLocale!.manageDapps,
              onTap: () => context.pushRoute(SavedDappsPage())),
          Divider(
            color: theme.whiteColor.withOpacity(0.08),
            height: 1,
          ),
          buildTile(
              iconAsset: IconConstants.chatIcon,
              text: context.getLocale!.helpAndFeedback,
              onTap: () => {}),
          Divider(
            color: theme.whiteColor.withOpacity(0.08),
            height: 1,
          ),
          const SizedBox(
            height: 30,
          ),
          TermsAndConditions(
            theme: theme,
            insideSettings: true,
          ),
          Text(
            "v1.0.0",
            style: theme.bodyTextStyle,
          ),
        ],
      ),
    );
  }

  Widget buildTile(
      {required String iconAsset,
      required String text,
      void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              iconAsset,
              height: 20,
              width: 20,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              text,
              style: theme.normalTextStyle2,
            )
          ],
        ),
      ),
    );
  }
}
