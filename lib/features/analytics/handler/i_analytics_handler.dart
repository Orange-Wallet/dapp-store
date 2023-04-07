abstract class IAnalyticsHandler {
  Future<bool?> intallDappEvent(
      {required String dappId, required Map<String, dynamic> metadata});
}
