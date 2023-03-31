import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/widgets/white_gradient_line.dart';
import 'package:flutter/material.dart';

typedef NavigationCallback = Function();

// ignore: must_be_immutable
class PwaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IThemeSpec theme;
  NavigationCallback forward;
  NavigationCallback backwards;
  int? progress;
  PwaAppBar({
    Key? key,
    required this.title,
    required this.theme,
    required this.forward,
    required this.backwards,
    this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppBar(
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
          bottom: const WhiteGradientLine(),
        ),
        if (progress != null && progress != 100)
          SizedBox(
            width: MediaQuery.of(context).size.width * (progress! / 100),
            child: Divider(
              thickness: 5,
              color: theme.black,
            ),
          ),
      ],
    );
  }

  @override
  final Size preferredSize = const Size.fromHeight(72.0);
}
