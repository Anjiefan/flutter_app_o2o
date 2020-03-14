
import 'package:flutter/cupertino.dart';
import 'package:yunzhixiao_business_client/models/system_message_list.dart';
import 'package:yunzhixiao_business_client/models/system_static_info.dart';
import 'package:yunzhixiao_business_client/providers/view_state_model.dart';
import 'package:yunzhixiao_business_client/service/system_repository.dart';

class SystemStaticModel extends ViewStateModel {
  SystemStaticInfo _systemStaticInfo;

  SystemStaticInfo get systemStaticInfo => _systemStaticInfo;

  SystemStaticModel() {
    initData();
  }
  initData() async {
    setBusy();
    _systemStaticInfo =await SystemRepository.getStaticInfo() as SystemStaticInfo;
    setIdle();
  }



}