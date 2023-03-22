abstract class IErrorLogger {
  initialise();
  Future<void> logError(Object e);
}
