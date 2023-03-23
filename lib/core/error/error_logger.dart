import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
part '../../generated/core/error/error_logger.freezed.dart';

part 'error_logger_state.dart';

@LazySingleton(as: IErrorLogger)
class ErrorLogger extends Cubit<ErrorLoggerState> implements IErrorLogger {
  ErrorLogger() : super(ErrorLoggerState.initial());

  @override
  initialise() {
    //todo: initilalise logger
  }
  @override
  Future<void> logError(Object e) {
    debugPrint("ERROR: ${e.toString()}");
    return Future.value();
  }
}
