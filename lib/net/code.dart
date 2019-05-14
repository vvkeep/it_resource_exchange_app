import 'package:event_bus/event_bus.dart';
import './http_error_event.dart';

class Code {
  //网络错误
  static const NETWORK_ERROR = -1;

  //请求超时
  static const NETWOEK_TIMEROUT = -2;

  //网络返回数据格式化一次
  static const NETWORK_JSON_EXCEPTION = -3;

  static const SUCCESS = 200;

  static final EventBus eventBus = EventBus();

  static errorHandle(code, message, isTip) {
    if (isTip) {
      eventBus.fire(HttpErrorEvent(code,  message));
    }
    return message;
  }
}