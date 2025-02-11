abstract class ZbjLogger {
  Future<ZbjLogger> initialize();

  void pageview(String pagename, [Map<String, Object> data, String? uri]);
  void customEvent(String customEvent, [Map<String, Object> data]);
  void fine(String message);
  void info(String message);
  void warning(String message);
  void severe(String message);

  void updateUserCode(String code);
}
