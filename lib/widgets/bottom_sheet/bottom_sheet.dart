import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/widgets/white_gradient_line.dart';
import 'package:flutter/material.dart';

extension BottomSheet on BuildContext {
  showBottomSheet({required IThemeSpec theme, required Widget child}) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: this,
      builder: (context) {
        return Container(
          color: Colors.transparent,
          margin: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Stack(
            children: [
              Card(
                shape: theme.sheetCardShape,
                color: theme.sheetBackgroundColor,
                child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Column(
                      children: [
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
                      ],
                    )),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 7.0),
                child: WhiteGradientLine(),
              ),
            ],
          ),
        );
      },
    );
  }
}
