import 'package:flutter/cupertino.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yunzhixiao_customer_client/commons/constants/config.dart';
import 'package:yunzhixiao_customer_client/commons/managers/storage_manager.dart';
import 'package:yunzhixiao_customer_client/commons/nets/handler.dart';
import 'package:yunzhixiao_customer_client/commons/nets/net_message.dart';
import 'package:yunzhixiao_customer_client/models/user.dart';
import 'package:yunzhixiao_customer_client/service/user_repository.dart';
import 'package:yunzhixiao_customer_client/service/wallet_repository.dart';

class UserModel extends ChangeNotifier {
  static const String kUser = Config.USER_KEY;

  bool hasInitPush = false;

  User _user;

  User get user => _user;

  bool get hasUser => user != null;

  UserModel() {
    var userMap = StorageManager.localStorage.getItem(kUser);
    _user = userMap != null ? User.fromJson(userMap) : null;
  }

  saveUser(User user) async {
    _user = user;
    notifyListeners();
    await StorageManager.localStorage.setItem(kUser, user);
  }

  /// 清除持久化的用户数据
  clearUser() async {
    _user = null;
    hasInitPush = false;
    notifyListeners();
    await StorageManager.localStorage.deleteItem(kUser);
    await StorageManager.localStorage.deleteItem(Config.IS_LOGIN_KEY);
    await StorageManager.localStorage.deleteItem(Config.IS_VERIFYING_KEY);
  }


  refreshUserInfo() async {
    String username = user.username;
    var newUser = await UserRepository.getUserInfo(username);
    saveUser(newUser);
    notifyListeners();
  }

  updateUserWithdrawAccount(context, {String alipayAccount, String wxPayAccount}) async {
    String username = user.username;
    try {
      await WalletRepository.updateWithdrawAccount(alipayAccount: alipayAccount, wxPayAccount: wxPayAccount, user: user);
      var newUser = await UserRepository.getUserInfo(username);
      saveUser(newUser);
      Future.microtask(() {
        showToast("信息修改成功！", context: context);
      });
    } catch (e) {
      showErrorByResponse(e,context);
    }
  }

  showErrorByResponse(var e,BuildContext context) {
    Future.microtask(() {
      showToast(
          ResponseMessage(Handler.errorHandleFunction(e.response.statusCode)
              , e.response.data).message, context: context);
    });
  }
  void setHasInitPush() {
    hasInitPush = true;
    notifyListeners();
  }




}
