import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/widgets/white_gradient_line.dart';
import 'package:flutter/material.dart';

extension BottomSheet on BuildContext {
  showBottomSheet({
    required IThemeSpec theme,
    required Widget child,
    bool dismissable = true,
    String? routeName,
    Function? callback,
  }) {
    showModalBottomSheet(
      routeSettings: RouteSettings(name: routeName),
      backgroundColor: Colors.transparent,
      context: this,
      isDismissible: dismissable,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(this).viewInsets.bottom,
            ),
            color: Colors.transparent,
            margin: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  shape: theme.sheetCardShape,
                  color: theme.sheetBackgroundColor,
                  child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 2.0),
                            child: WhiteGradientLine(),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 28.0),
                            child: Container(
                              width: 88,
                              height: 4,
                              decoration: BoxDecoration(
                                color: theme.ratingGrey,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          child,
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        );
      },
    ).whenComplete(() {
      callback?.call();
    });
  }
}
