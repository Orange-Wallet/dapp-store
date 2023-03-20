import 'package:dappstore/core/platform_channel/platform_channel_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part '../../../../../generated/features/download_and_installer/infrastructure/repositories/foreground_service/foreground_service_cubit.freezed.dart';
part 'foreground_service_state.dart';

class ForegroundService extends Cubit<PlatformChannelState> {
  ForegroundService(super.initialState);
}
