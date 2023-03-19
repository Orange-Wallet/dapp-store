import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/pwa_webview_cubit.dart';
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/pwa_webview_cubit_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PwaWebView extends StatelessWidget {
  const PwaWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IPwaWebviewCubit, PwaWebviewState>(
      builder: (context, state) {
        return Container();
      },
    );
  }
}
