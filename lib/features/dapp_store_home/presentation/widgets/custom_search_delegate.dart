import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomSearchDelegate extends SearchDelegate {
  IDappStoreHandler handler;
  CustomSearchDelegate({required this.handler, required BuildContext context})
      : super(
          searchFieldStyle: handler.theme.whiteBoldTextStyle,
          searchFieldLabel: context.getLocale!.whatAreYouLooking,
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      backgroundColor: handler.theme.secondaryBackgroundColor,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: !handler.theme.isDarkTheme
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light,
        backgroundColor: handler.theme.appBarBackgroundColor,
        toolbarTextStyle: handler.theme.whiteBoldTextStyle,
        titleTextStyle: handler.theme.whiteBoldTextStyle,
      ),
      useMaterial3: true,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: handler.theme.bodyTextStyle,
        isDense: true,
        border: InputBorder.none,
        fillColor: handler.theme.secondaryBackgroundColor,
        focusColor: handler.theme.secondaryBackgroundColor,
        filled: true,
      ),
    );
  }

// clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(
          Icons.clear,
          color: handler.theme.whiteColor,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(
        Icons.arrow_back,
        color: handler.theme.whiteColor,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchResult(
      handler: handler,
      query: query,
      key: ValueKey(query),
    );
  }

// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
