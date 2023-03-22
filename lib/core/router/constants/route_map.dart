import 'package:dappstore/features/dapp_store_home/presentation/screen/homepage.dart';
import 'package:flutter/material.dart';

class RouteMap {
  RouteMap._();

  static Map<String, Widget Function(BuildContext)> routes = {
    HomePage().route: (context) => HomePage(),
  };
}
