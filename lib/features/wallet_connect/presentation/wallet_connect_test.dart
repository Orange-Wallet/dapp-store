import 'dart:developer';

import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/wallet_connect_cubit.dart';
import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
            child: const Text("Connecet")),
        ElevatedButton(
            onPressed: () async {
              var cubit = getIt<WalletConnectCubit>();
              var res = await cubit.getPersonalSign("Testing");
              log(res.toString());
              var add = EthSigUtil.ecRecover(
                  message: Uint8List.fromList("Testing".codeUnits),
                  signature: res);
              // var add = EthSigUtil.ecRecover(
              //   signature:
              //       "0x1ba8be3db5c49f62795c78d580814ed5f63151a1ce2ce70435b01ae4e2aa141037e8b0ae09af3677b689275c9c0d5dec56a0ead0dae5852cfcea63186298de331c",
              //   message: Uint8List.fromList("Testing ".codeUnits),
              // );
              log(add.toString());
            },
            child: const Text("personal Sign")),
        ElevatedButton(
            onPressed: () {
              var cubit = getIt<WalletConnectCubit>();
              cubit.disconnectAll();
            },
            child: const Text("delete all"))
      ],
    );
  }
}
