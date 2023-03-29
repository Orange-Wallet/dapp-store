import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_info/presentation/widgets/dapp_title_tile.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/widgets/cards/default_card.dart';
import 'package:flutter/material.dart';

class SimilarApps extends StatelessWidget {
  final IThemeSpec theme;
  final List<DappInfo?>? dappList;
  const SimilarApps({super.key, required this.theme, required this.dappList});
  final divider = const Padding(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
    child: Divider(
      thickness: 2,
    ),
  );
  @override
  Widget build(BuildContext context) {
    final widgets = dappList?.map((e) {
      if (e == null) {
        return const SizedBox();
      }
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: DappTitleTile(
              theme: theme,
              dappInfo: e,
              primaryTile: false,
            ),
          ),
          divider,
        ],
      );
    });
    if (dappList == null || widgets == null) {
      return const SizedBox();
    }
    return DefaultCard(
        theme: theme,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    context.getLocale!.youMightLike,
                    style: theme.titleTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: widgets.length * 100,
              child: Column(
                children: widgets.toList(),
              ),
            ),
            const SafeArea(child: SizedBox())
          ],
        ));
  }
}
