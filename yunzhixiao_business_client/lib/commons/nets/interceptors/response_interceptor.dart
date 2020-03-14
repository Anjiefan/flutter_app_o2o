import 'package:dio/dio.dart';
import 'package:yunzhixiao_business_client/commons/nets/constants/code.dart';
import 'package:yunzhixiao_business_client/commons/nets/handler.dart';
import 'package:yunzhixiao_business_client/commons/nets/net_message.dart';
import 'package:yunzhixiao_business_client/commons/nets/response_data.dart';
import 'package:yunzhixiao_business_client/commons/nets/response_exception.dart';


class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response) async {
    RequestOptions option = response.request;
    var value;
    try {
      var header = response.headers[Headers.contentTypeHeader];
      if ((header != null && header.toString().contains("text"))) {
        value = new ResponseData(response.data, true, Code.SUCCESS);
      } else if (response.statusCode >= 200 && response.statusCode < 300) {
        value = new ResponseData(response.data, true, Code.SUCCESS,
            headers: response.headers);
      }
    } catch (e) {
      print(e.toString() + option.path);
      if(response.statusCode==Code.AUTH_ERROR){
        throw UnAuthorizedException();
      }
      throw NotSuccessException.fromRespData(ResponseMessage(Handler.errorHandleFunction(response.statusCode),response.data));
    }
    return value;
  }
}
