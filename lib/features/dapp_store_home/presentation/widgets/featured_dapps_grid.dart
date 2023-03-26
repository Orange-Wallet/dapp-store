import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/presentation/screen/explore_categories.dart';
import 'package:dappstore/widgets/image_widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeaturedDappsGrid extends StatefulWidget {
  const FeaturedDappsGrid({super.key});

  @override
  State<FeaturedDappsGrid> createState() => _FeaturedDappsGridState();
}

class _FeaturedDappsGridState extends State<FeaturedDappsGrid> {
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
            padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Chip(
                  label: Text(
                    context.getLocale!.featuredDapps,
                    style: handler.theme.secondaryTextStyle2,
                  ),
                  backgroundColor: handler.theme.secondaryBackgroundColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                ),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shrinkWrap: true,
                  addAutomaticKeepAlives: true,
                  cacheExtent: 200,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: 16,
                  itemBuilder: (BuildContext context, int index) {
                    return getGridTile(list[index]);
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextButton(
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
                    )),
              ],
            ),
          );
        });
  }

  Widget getGridTile(DappInfo? dapp) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(handler.theme.imageBorderRadius),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          //TODO add onclick redirection to dappinfo page
        },
        borderRadius: BorderRadius.circular(handler.theme.imageBorderRadius),
        child: ImageWidgetCached(
          dapp!.images!.logo!,
          height: 74,
          width: 74,
        ),
      ),
    );
  }
}
