import 'package:dappstore/core/application/app.dart';
import 'package:dappstore/core/application/init/init.dart';
import 'package:flutter/material.dart';

void main() async {
  await initialise();
  runApp(const App());
}
