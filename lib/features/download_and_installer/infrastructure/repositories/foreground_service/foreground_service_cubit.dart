import 'package:dappstore/core/platform_channel/i_platform_channel_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part '../../../../../generated/features/download_and_installer/infrastructure/repositories/foreground_service/foreground_service_cubit.freezed.dart';
part 'foreground_service_state.dart';

class ForegroundService extends Cubit<ForegroundServiceState> {
  final IPlatformChannelCubit platformChannelCubit;
  static const startServiceMethod = "StartForegroundService";
  static const stopServiceMethod = "StopForegroundService";
  static const isServiceRunningMethod = "IsForegroundServiceRunning";

  ForegroundService({required this.platformChannelCubit})
      : super(ForegroundServiceState.initial());
  startForegroundService() async {
    final bool status = await platformChannelCubit.call(startServiceMethod, []);
    emit(state.copyWith(isRunning: status));
  }

  stopForegroundService() async {
    final bool status = await platformChannelCubit.call(stopServiceMethod, []);
    emit(state.copyWith(isRunning: status));
  }

  Future<bool> statusForegroundService() async {
    final bool status =
        await platformChannelCubit.call(isServiceRunningMethod, []);
    emit(state.copyWith(isRunning: status));
    return status;
  }
}
