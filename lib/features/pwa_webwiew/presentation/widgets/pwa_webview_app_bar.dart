import 'package:flutter/material.dart';

import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';

typedef NavigationCallback = Function();

// ignore: must_be_immutable
class PwaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IThemeSpec theme;
  NavigationCallback forward;
  NavigationCallback backwards;
  PwaAppBar({
    Key? key,
    required this.title,
    required this.theme,
    required this.forward,
    required this.backwards,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: theme.appBarBackgroundColor,
      leading: InkWell(
        onTap: context.popRoute,
        child: Icon(
          Icons.close,
          color: theme.whiteColor,
        ),
      ),
      title: Text(
        title,
        style: theme.headingTextStyle,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: backwards,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: theme.whiteColor,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: forward,
            child: Center(
              child: Icon(
                Icons.arrow_forward_ios,
                color: theme.whiteColor,
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  final Size preferredSize = const Size.fromHeight(52.0);
}
