import 'package:dappstore/features/wallet_connect/infrastructure/cubit/wallet_connect_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class IWalletConnectCubit extends Cubit<WalletConnectState> {
  IWalletConnectCubit() : super(WalletConnectState.initial());
}
