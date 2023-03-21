import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/wallet_connect_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class WCTestWidget extends StatelessWidget {
  const WCTestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () async {
              var cubit = getIt<WalletConnectCubit>();
              await cubit.initialize();
              cubit.getConnectRequest(["eip155:137", "eip155:1"]);
            },
            child: Text("Connecet")),
        ElevatedButton(
            onPressed: () {
              var cubit = getIt<WalletConnectCubit>();
              cubit.getPersonalSign("Testing");
            },
            child: Text("personal Sign")),
        ElevatedButton(
            onPressed: () {
              var cubit = getIt<WalletConnectCubit>();
              cubit.disconnectAll();
            },
            child: Text("delete all"))
      ],
    );
  }
}
