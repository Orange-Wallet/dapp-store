import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/wallet_connect_cubit.dart';
import 'package:dappstore/utils/icon_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TxPopup extends StatelessWidget {
  final IThemeSpec theme;
  final IWalletConnectCubit walletConnectCubit;
  const TxPopup(
      {super.key, required this.theme, required this.walletConnectCubit});

  @override
  Widget build(BuildContext context) {
    return Center(
      //   child: BlocCo(
      child: BlocConsumer<IWalletConnectCubit, WalletConnectState>(
          bloc: walletConnectCubit,
          listener: (context, state) {
            if (state.txSucesess) {
              context.popRoute();
            }
          },
          builder: (context, state) {
            return _DialogTileItem(
              title: context.getLocale!.approveRequest,
              subtitle: context.getLocale!.approveRequestSubtitle,
              theme: theme,
              leading: Image.asset(IconConstants.walletConnectLogo,
                  height: theme.wcIconSize),
              success: state.txSucesess,
              loading: state.txLoading,
              error: state.txFailure,
            );
          }),
    );
  }
}

class _DialogTileItem extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String subtitle;
  final bool loading;
  final bool success;
  final bool error;
  final IThemeSpec theme;
  const _DialogTileItem({
    Key? key,
    this.leading,
    required this.title,
    required this.subtitle,
    this.loading = false,
    this.success = false,
    this.error = false,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50.0,
            width: 50.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.backgroundColor,
            ),
            child: loading
                ? SizedBox(
                    height: 18.0,
                    width: 18.0,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: theme.whiteColor,
                        strokeWidth: 2.5,
                      ),
                    ),
                  )
                : success
                    ? Icon(
                        Icons.check_rounded,
                        size: 24.0,
                        color: theme.appGreen,
                      )
                    : error
                        ? Icon(
                            Icons.close_rounded,
                            size: 24.0,
                            color: theme.errorRed,
                          )
                        : leading ??
                            Text(
                              "",
                              style: theme.buttonTextStyle.copyWith(
                                fontSize: 24.0,
                              ),
                            ),
          ),
          const SizedBox(width: 24.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.buttonTextStyle.copyWith(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  subtitle,
                  style: theme.bodyTextStyle.copyWith(
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
