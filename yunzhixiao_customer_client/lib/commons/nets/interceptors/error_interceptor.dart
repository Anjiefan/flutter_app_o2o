import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:yunzhixiao_customer_client/commons/nets/constants/code.dart';
import 'package:yunzhixiao_customer_client/commons/nets/handler.dart';
import 'package:yunzhixiao_customer_client/commons/nets/net_message.dart';
import 'package:yunzhixiao_customer_client/commons/nets/response_data.dart';
import 'package:yunzhixiao_customer_client/commons/nets/response_exception.dart';

//const NOT_TIP_KEY = "noTip";


class ErrorInterceptors extends InterceptorsWrapper {

  ErrorInterceptors();

  @override
  onRequest(RequestOptions options) async {
    //没有网络
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      throw NotSuccessException.fromRespData(RequestMessage(message: Handler.errorHandleFunction(Code.NETWORK_ERROR)));
    }
    return options;
  }
}
