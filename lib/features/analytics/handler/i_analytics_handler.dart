import 'package:dappstore/features/analytics/dtos/install_analytics_model.dart';

abstract class IAnalyticsHandler {
  Future<bool?> intallDappEvent(
      {required InstallAnalyticsDTO installAnalyticsDTO});
}
