import 'package:flutter/cupertino.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yunzhixiao_business_client/models/system_message_list.dart';
import 'package:yunzhixiao_business_client/service/order_repository.dart';
import 'package:yunzhixiao_business_client/service/system_repository.dart';
import 'package:yunzhixiao_business_client/view_model/order/order_home_info_model.dart';
import 'package:yunzhixiao_business_client/view_model/order/order_model.dart';

class PushModel extends ChangeNotifier {
  OrderListModel _newOrderListModel;
  OrderListModel _prepareOrderListModel;
  OrderHomeInfoModel _orderHomeInfoModel;
  SystemMessageNumDetail systemMessageNumDetail;

  onNewOrderListModelReady(orderListModel) {
    _newOrderListModel = orderListModel;
    notifyListeners();
  }

  onPrepareOrderListModelReady(orderListModel) {
    _prepareOrderListModel = orderListModel;
    notifyListeners();
  }

  onOrderHomeInfoModelReady(orderHomeInfoModel) {
    _orderHomeInfoModel = orderHomeInfoModel;
    notifyListeners();
  }

  onRefreshOrderHomeInfoModel() {
    if (_orderHomeInfoModel != null) {
      _orderHomeInfoModel.refresh();
    }
  }

  onRefreshNewOrderListModel() {
    if (_newOrderListModel != null) {
      _newOrderListModel.refresh();
    }
  }

  onRefreshPrepareOrderListModel() async {
    if (_prepareOrderListModel != null) {
      _prepareOrderListModel.refresh();
    }
  }

  onAutoOrder(context) async {
    if (_newOrderListModel != null) {
      print("!!!!!onAutoOrder");
      await _newOrderListModel.refresh();
      int length = _newOrderListModel.list.length;
      for (int i = 0; i < length; i++) {
        try {
          await OrderRepository.updateOrder(_newOrderListModel.list[i].id,
              commodity_status: 0);
          if (_orderHomeInfoModel != null) {
            _orderHomeInfoModel.onSwitchTab(1);
          }
          onRefreshPrepareOrderListModel();
          await _newOrderListModel.refresh();
          onRefreshOrderHomeInfoModel();
          Future.microtask(() {
            showToast("已为您自动接单，请及时查看。", context: context);
          });
        } catch (e) {}
      }
    }
  }

  refreshSystemMessageNum() async {
    systemMessageNumDetail = await SystemRepository.fetchSystemMessageNum();
    notifyListeners();
  }
}
