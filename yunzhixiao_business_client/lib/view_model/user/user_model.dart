import 'package:flutter/cupertino.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yunzhixiao_business_client/commons/constants/config.dart';
import 'package:yunzhixiao_business_client/commons/managers/storage_manager.dart';
import 'package:yunzhixiao_business_client/models/user.dart';
import 'package:yunzhixiao_business_client/service/user_repository.dart';
import 'package:yunzhixiao_business_client/service/wallet_repository.dart';

class UserModel extends ChangeNotifier {
  static const String kUser = Config.USER_KEY;

  User _user;

  User get user => _user;

  bool get hasUser => user != null;

  UserModel() {
    var userMap = StorageManager.localStorage.getItem(kUser);
    _user = userMap != null ? User.fromJson(userMap) : null;
  }

  saveUser(User user) {
    _user = user;
    notifyListeners();
    StorageManager.localStorage.setItem(kUser, user);
  }

  /// 清除持久化的用户数据
  clearUser() async {
    _user = null;
    notifyListeners();
    await StorageManager.localStorage.deleteItem(kUser);
    await StorageManager.sharedPreferences.remove(Config.IS_LOGIN_KEY);
    await StorageManager.sharedPreferences.remove(Config.VERIFYING_STATUS);
  }

  openOrCloseShop(context) async {
    int shopId = user.shop.id;
    String username = user.username;
    bool isOpen = user.shop.isOpen;
    try {
      await UserRepository.updateUserShopInfo(shopId, {
        "is_open": !isOpen,
      });
    } catch (e) {
      Future.microtask(() {
        showToast(e.response.data[0], context: context);
      });
    }
    var newUser = await UserRepository.getUserInfo(username);
    saveUser(newUser);
  }

  refreshUserInfo() async {
    String username = "clear";
    var newUser = await UserRepository.getUserInfo(username);
    saveUser(newUser);
  }

  updateUserShopInfo(data, context) async {
    int shopId = user.shop.id;
    String username = user.username;
    try {
      await UserRepository.updateUserShopInfo(shopId, data);
      var newUser = await UserRepository.getUserInfo(username);
      saveUser(newUser);
      Future.microtask(() {
        showToast("信息修改成功！", context: context);
      });
    } catch (e) {
      Future.microtask(() {
        showToast(e.response.data[0], context: context);
      });
    }

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
      Future.microtask(() {
        showToast(e.response.data[0], context: context);
      });
    }
  }

}
