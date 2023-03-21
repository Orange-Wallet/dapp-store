import 'package:dappstore/features/wallet_connect/models/chain_data.dart';
import 'package:dappstore/features/wallet_connect/models/chain_metadata.dart';
import 'package:dappstore/features/wallet_connect/utils/eip155.dart';
import 'package:flutter/material.dart';

String getChainName(String chainId) {
  try {
    return ChainData.allChains
        .where((element) => element.chainId == chainId)
        .first
        .name;
  } catch (e) {
    debugPrint('Invalid chain');
  }
  return 'Unknown';
}

ChainMetadata getChainMetadataFromChainId(String chainId) {
  try {
    return ChainData.allChains
        .where((element) => element.chainId == chainId)
        .first;
  } catch (e) {
    debugPrint('Invalid chain');
  }
  return ChainData.mainChains[0];
}

List<String> getChainMethods(ChainType value) {
// currently only supports EVM
  return Eip155Data.methods.values.toList();
}

List<String> getChainEvents(ChainType value) {
  // currently only supports EVM
  return Eip155Data.events.values.toList();
}
