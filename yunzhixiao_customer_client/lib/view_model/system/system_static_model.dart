
import 'package:flutter/cupertino.dart';
import 'package:yunzhixiao_customer_client/models/order_num.dart';
import 'package:yunzhixiao_customer_client/models/system_message_list.dart';
import 'package:yunzhixiao_customer_client/models/system_static_info.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_model.dart';
import 'package:yunzhixiao_customer_client/service/order_repository.dart';
import 'package:yunzhixiao_customer_client/service/system_repository.dart';

class SystemStaticModel extends ViewStateModel {
  SystemStaticInfo _systemStaticInfo;
  SystemMessageNumDetail systemMessageNumDetail;
  OrderNum orderNum;

  SystemStaticInfo get systemStaticInfo => _systemStaticInfo;

  SystemStaticModel() {
    initData();
  }
  initData() async {
    setBusy();
    _systemStaticInfo =await SystemRepository.getStaticInfo() as SystemStaticInfo;
    refreshSystemMessageNum();
    refreshOrderNum();
    setIdle();
  }

  refreshSystemMessageNum() async {
    systemMessageNumDetail = await SystemRepository.fetchSystemMessageNum();
    notifyListeners();
  }

  refreshOrderNum() async {
    orderNum = await OrderRepository.fetchOrderNum();
    notifyListeners();
  }

}