import 'package:dappstore/features/dapp_store_home/domain/entities/curated_list.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_list.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part '../../../../generated/features/dapp_store_home/application/store_cubit/store_cubit.freezed.dart';
part '../../../../generated/features/dapp_store_home/application/store_cubit/store_cubit.g.dart';
part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit() : super(StoreState.initial());

  @override
  Future<void> close() {
    return super.close();
  }
}
