import 'package:yunzhixiao_business_client/commons/nets/constants/code.dart';
import 'package:yunzhixiao_business_client/commons/nets/constants/code_message.dart';

class Handler{
  static errorHandleFunction(int code) {
    switch (code) {
      case Code.NETWORK_ERROR:
        return ErrorMessage.network_error;
        break;
      case 401:
        return ErrorMessage.network_error_401;
        break;
      case 403:
        return ErrorMessage.network_error_403;
        break;
      case 404:
        return ErrorMessage.network_error_404;
        break;
      case Code.NETWORK_TIMEOUT:
      //超时
        return ErrorMessage.network_error_timeout;
        break;
      default:
        return ErrorMessage.network_error_unknown;
        break;
    }
  }
}