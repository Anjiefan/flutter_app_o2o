import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yunzhixiao_business_client/service/order_repository.dart';

import 'order_model.dart';

class OrderHomeInfoModel extends ChangeNotifier {
  Map<String, int> orderNums = {
    "新订单": 0,
    "等待备餐": 0,
    "等待取餐": 0,
    "催单": 0,
    "取消单": 0
  };
  var _tabController;
  OrderListModel currentOrderListModel;

  refresh() {
    OrderRepository.fetchOrderNum().then((result) {
      orderNums["新订单"] = result.newOrder;
      orderNums["等待备餐"] = result.preparing;
      orderNums["等待取餐"] = result.already;
      orderNums["催单"] = result.hurry;
      orderNums["取消单"] = result.cancel;
      notifyListeners();
    });
  }

  onSetTabController(tabController) {
    _tabController = tabController;
    notifyListeners();
  }

  onSwitchTab(int where){
    if (_tabController != null){
      _tabController.animateTo(where);
      print("!!!!onSwitchTab");
    }
    notifyListeners();
  }
}
