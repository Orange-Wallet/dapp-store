import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
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
            previous.dappList.hashCode != current.dappList.hashCode,
        bloc: handler.getStoreCubit(),
        builder: (context, state) {
          // TODO currently using dapplist instead of curated list
          List<DappInfo?>? list = state.dappList?.response;
          if (list == null) {
            return Container();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 21, top: 70),
                child: Chip(
                  label: Text(
                    context.getLocale!.featuredDapps,
                    style: handler.theme.buttonTextStyle,
                  ),
                  backgroundColor: handler.theme.secondaryBackgroundColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                ),
              ),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 21, vertical: 12),
                shrinkWrap: true,
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
            ],
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
        child: ImageWidget(
          dapp!.images!.logo!,
          height: 74,
          width: 74,
          enableNetworkCache: true,
          placeholderType: PlaceholderType.nftItemSymbol,
        ),
      ),
    );
  }
}