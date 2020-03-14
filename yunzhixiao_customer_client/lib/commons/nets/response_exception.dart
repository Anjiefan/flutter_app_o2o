
import 'package:yunzhixiao_customer_client/commons/utils/message.dart';

import 'net_message.dart';

/// 接口的code没有返回为true的异常
class NotSuccessException implements Exception {
  String message;

  NotSuccessException.fromRespData(Message requestMessage) {

    message = requestMessage.message;
  }

  @override
  String toString() {
    return '$message';
  }
}

/// 用于未登录等权限不够,需要跳转授权页面
class UnAuthorizedException implements Exception {
  const UnAuthorizedException();

  @override
  String toString() => '登录以享受更多服务';
}
