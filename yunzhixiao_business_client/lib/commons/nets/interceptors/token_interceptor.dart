import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:yunzhixiao_business_client/commons/constants/config.dart';
import 'package:yunzhixiao_business_client/commons/managers/storage_manager.dart';


class TokenInterceptors extends InterceptorsWrapper {
  String _token;

  @override
  onRequest(RequestOptions options) async {
    //授权码
    if (_token == null) {
      var authorizationCode = await getAuthorization();
      if (authorizationCode != Null) {
        _token = authorizationCode;
        options.headers["Authorization"] = _token;
      }
    }
    else{
      if (_token.contains('Token')){
        options.headers["Authorization"] = '$_token';
      }
      else{
        options.headers["Authorization"] = 'Token $_token';
      }
    }
    return options;
  }

  @override
  onResponse(Response response) async {
    try {
      var responseJson = response.data;
      if (response.statusCode == 201 && responseJson["token"] != null) {
        _token = responseJson["token"];
        StorageManager.sharedPreferences.setString(Config.TOKEN_KEY, _token);
      }
    } catch (e) {
      print(e);
    }
    return response;
  }

  ///清除授权
  clearAuthorization() async {
    this._token = null;
    await StorageManager.sharedPreferences.remove(Config.TOKEN_KEY);
  }

  ///获取授权token
  getAuthorization() async {
    String token = StorageManager.sharedPreferences.getString(Config.TOKEN_KEY);
    log('token=$token');
    if (token == null) {
      return Null;
    } else {
      return "Token $token";
    }
  }
}
