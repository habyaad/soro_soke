import 'package:logger/logger.dart';

class LoggerService {
  var logger = Logger();

  void error(String msg) {
    logger.e(msg, 'Error');
  }

  void info(String msg) {
    logger.i(msg, 'Info');
  }

  void warning(String msg) {
    logger.w(msg, 'Warning');
  }

  void message(String msg) {
    logger.d(msg, 'Message');
  }
}
