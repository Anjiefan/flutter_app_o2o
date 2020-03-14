import 'package:oktoast/oktoast.dart';
import 'package:yunzhixiao_business_client/commons/constants/config.dart';
import 'package:yunzhixiao_business_client/commons/managers/storage_manager.dart';
import 'package:yunzhixiao_business_client/commons/nets/handler.dart';
import 'package:yunzhixiao_business_client/commons/nets/http.dart';
import 'package:yunzhixiao_business_client/commons/nets/net_message.dart';
import 'package:yunzhixiao_business_client/models/user.dart';
import 'package:yunzhixiao_business_client/providers/view_state_model.dart';
import 'package:yunzhixiao_business_client/service/user_repository.dart';

import 'user_model.dart';

class LoginModel extends ViewStateModel {
  final UserModel userModel;

  LoginModel(this.userModel) : assert(userModel != null);

  Future<bool> loginUsernamePassword(username, password, context) async {
    setBusy();
    try {
      var data = await UserRepository.loginUsernamePassword(username, password);
      var token = data["token"];
      var status = data["status"];
      await StorageManager.sharedPreferences
            .setString(Config.TOKEN_KEY, token);
      if (status == 1) {
        //登录成功
        User user = await UserRepository.getUserInfo(username);
        userModel.saveUser(user);
        await StorageManager.sharedPreferences
            .setBool(Config.IS_LOGIN_KEY, true);
      } else {
        //进入认证页面
        print("status=$status");
        await StorageManager.sharedPreferences.remove(Config.IS_LOGIN_KEY);
        await StorageManager.sharedPreferences.setInt(Config.VERIFYING_STATUS, status);
        return false;
      }
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      setIdle();
      Future.microtask(() {
        showToast(
            ResponseMessage(Handler.errorHandleFunction(e.response.statusCode),
                    e.response.data)
                .message,
            context: context);
      });
      return false;
    }
  }

  Future<bool> loginUsernameCode(username, code, context) async {
    setBusy();
    try {
      var data = await UserRepository.loginUsernameCode(username, code);
      var token = data["token"];
      var status = data["status"];
      await StorageManager.sharedPreferences
            .setString(Config.TOKEN_KEY, token);
      if (status == 1) {
        //登录成功
        User user = await UserRepository.getUserInfo(username);
        userModel.saveUser(user);
        await StorageManager.sharedPreferences
            .setBool(Config.IS_LOGIN_KEY, true);
      } else {
        //进入认证页面
        print("status=$status");
        await StorageManager.sharedPreferences.remove(Config.IS_LOGIN_KEY);
        await StorageManager.sharedPreferences.setInt(Config.VERIFYING_STATUS, status);
        return false;
      }
      return true;
    } catch (e, s) {
      setError(e, s);
      setIdle();
      Future.microtask(() {
        showToast(
            ResponseMessage(Handler.errorHandleFunction(e.response.statusCode),
                    e.response.data)
                .message,
            context: context);
      });
      return false;
    }
  }

  Future<bool> changePassword(code, password, context) async {
    setBusy();
    int id = userModel.user.id;
    try {
      await UserRepository.changePassword(id, password, code);
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      return false;
    }
  }

  Future<bool> register(code, password, username) async {
    setBusy();
    try {
      await UserRepository.register(username, password, code);
      var user = await UserRepository.getUserInfo(username);
      userModel.saveUser(user);

      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      return false;
    }
  }

  Future<bool> logout() async {
    if (!userModel.hasUser) {
      //防止递归
      return false;
    }
    setBusy();
    try {
//      await WanAndroidRepository.logout();
      userModel.clearUser();
      http.clearAuthorization();
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      return false;
    }
  }
}
