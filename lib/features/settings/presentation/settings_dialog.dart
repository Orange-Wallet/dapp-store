import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:dappstore/features/wallet_connect/presentation/wallet_connect_screen.dart';
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
                    getIt<IWalletConnectCubit>().getActiveAdddress().toString(),
                    style: theme.secondaryTextStyle2,
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
                    "Logout",
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
          const SizedBox(
            height: 12,
          ),
          Row(
            children: const [Icon(Icons.apps), Text("Manage Dapps")],
          ),
          const SizedBox(
            height: 12,
          ),
          Divider(
            color: theme.whiteColor.withOpacity(0.08),
            height: 1,
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: const [Icon(Icons.apps), Text("Manage Dapps")],
          )
        ],
      ),
    );
  }
}
