import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_business_client/commons/constants/config.dart';
import 'package:yunzhixiao_business_client/commons/managers/storage_manager.dart';
import 'package:yunzhixiao_business_client/commons/routers/router.dart';
import 'package:yunzhixiao_business_client/models/verification_info.dart';
import 'package:yunzhixiao_business_client/providers/view_state_model.dart';
import 'package:yunzhixiao_business_client/service/user_repository.dart';
import 'package:yunzhixiao_business_client/view_model/user/user_model.dart';

class VerificationEditModel extends ViewStateModel {
  int status = -1;
  int typeId;
  String typeName = "";
  int schoolId;
  String schoolName = "";
  VerificationInfo verificationInfo;

  VerificationEditModel(context) {
    refresh(context);
  }

  Future<void> refresh(context) async {
    setBusy();
    var statusInfo = await UserRepository.getVerificationStatus();
    status = statusInfo["status"];
    if (status == 0) {
      verificationInfo = await UserRepository.getVerificationInfo();
      typeId = verificationInfo.type.id;
      typeName = verificationInfo.type.name;
      schoolId = verificationInfo.school.id;
      schoolName = verificationInfo.school.name;
    } else if (status == -1) {
      verificationInfo = VerificationInfo(
        name: "",
        logo: "",
        phoneNum: "",
        address: "",
      );
    } else if (status == 2) {
      Future.microtask(() {
        showToast("审核已通过");
      });
      verificationInfo = await UserRepository.getVerificationInfo();
      var model = Provider.of<UserModel>(context);
      model.refreshUserInfo();
      await StorageManager.sharedPreferences.setBool(Config.IS_LOGIN_KEY, true);
      if (model.user != null) {
        Navigator.of(context).pushReplacementNamed(RouteName.tab);
      } else {
        Navigator.of(context).pushReplacementNamed(RouteName.login);
      }
    }
    notifyListeners();
    setIdle();
  }

  Future<bool> createVerificationInfo(context) async {
    setBusy();
    try {
      await UserRepository.createVerificationInfo({
        "logo": verificationInfo.logo,
        "name": verificationInfo.name,
        "phone_num": verificationInfo.phoneNum,
        "address": verificationInfo.address,
        "type": typeId,
        "school": schoolId
      });
      Future.microtask(() {
        showToast("店铺审核申请成功！");
      });
      refresh(context);
      return true;
    } catch (e, s) {
      setError(e, s);
      this.showErrorMessage(context);
      refresh(context);
      return false;
    }
  }

  Future<bool> updateVerificationInfo(context) async {
    setBusy();
    try {
      await UserRepository.updateVerificationInfo(verificationInfo.id, {
        "logo": verificationInfo.logo,
        "name": verificationInfo.name,
        "phone_num": verificationInfo.phoneNum,
        "address": verificationInfo.address,
        "type": typeId,
        "school": schoolId
      });
      Future.microtask(() {
        showToast("店铺审核申请修改成功！");
      });
      refresh(context);
      return true;
    } catch (e, s) {
      setError(e, s);
      this.showErrorMessage(context);
      refresh(context);
      return false;
    }
  }
}
