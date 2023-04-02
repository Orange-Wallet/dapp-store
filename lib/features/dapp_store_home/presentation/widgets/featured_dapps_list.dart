import 'dart:math';

import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/features/dapp_info/presentation/screens/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/presentation/screen/explore_categories.dart';
import 'package:dappstore/widgets/image_widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeaturedDappsList extends StatefulWidget {
  const FeaturedDappsList({super.key});

  @override
  State<FeaturedDappsList> createState() => _FeaturedDappsListState();
}

class _FeaturedDappsListState extends State<FeaturedDappsList> {
  late final IDappStoreHandler handler;
  @override
  void initState() {
    handler = DappStoreHandler();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IStoreCubit, StoreState>(
        buildWhen: (previous, current) =>
            previous.featuredDappList.hashCode !=
            current.featuredDappList.hashCode,
        bloc: handler.getStoreCubit(),
        builder: (context, state) {
          List<DappInfo?>? list = state.featuredDappList?.response;
          if (list == null) {
            return Container();
          }
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shrinkWrap: true,
                addAutomaticKeepAlives: true,
                scrollDirection: Axis.horizontal,
                cacheExtent: 200,
                itemCount: 16,
                itemBuilder: (BuildContext context, int index) {
                  return listTile(list[index], index % 2 != 0);
                },
              ),
            ),
          );
        });
  }

  Widget listTile(DappInfo? dapp, bool green) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          handler.setActiveDappId(dappId: dapp!.dappId ?? "");
          context.pushRoute(const DappInfoPage());
        },
        borderRadius: BorderRadius.circular(handler.theme.buttonRadius),
        child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width / 2,
            foregroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(handler.theme.buttonRadius),
              backgroundBlendMode: BlendMode.screen,
              border: Border.all(
                  color:
                      green ? handler.theme.cardGreen : handler.theme.cardBlue,
                  width: 1),
              gradient: LinearGradient(
                colors: [
                  handler.theme.whiteColor.withOpacity(0),
                  handler.theme.whiteColor.withOpacity(0.2),
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(handler.theme.buttonRadius),
              color: green ? handler.theme.cardGreen : handler.theme.cardBlue,
              border: Border.all(
                  color:
                      green ? handler.theme.cardGreen : handler.theme.cardBlue,
                  width: 1),
              backgroundBlendMode: BlendMode.screen,
            ),
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Transform.rotate(
                    angle: 2 * pi / 3,
                    child: Icon(
                      Icons.arrow_back,
                      color: handler.theme.whiteColor.withOpacity(0.2),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    circularImage(dapp?.images?.logo ?? ""),
                    Text(
                      dapp?.name ?? "",
                      style: handler.theme.normalTextStyle,
                    ),
                    Text(
                      dapp?.description ?? "",
                      style: handler.theme.bodyTextStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          handler.theme.vSmallRadius,
                        ),
                        color: Colors.white24,
                      ),
                      child: Text(
                        dapp?.category ?? "",
                        style: handler.theme.secondaryTextStyle2,
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  Widget circularImage(String image) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2000),
          border: Border.all(color: handler.theme.whiteColor, width: 1.5)),
      clipBehavior: Clip.antiAlias,
      child: ImageWidgetCached(
        image,
        width: 60,
        height: 60,
      ),
    );
  }

  Widget getExpolreMore() {
    return TextButton(
        onPressed: () {
          context.pushRoute(const ExploreCategories());
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
              handler.theme.secondaryBackgroundColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.getLocale!.exploreMore,
                style: handler.theme.normalTextStyle,
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: handler.theme.whiteColor,
              ),
            ],
          ),
        ));
  }
}
