import 'package:flutter/cupertino.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yunzhixiao_customer_client/commons/nets/handler.dart';
import 'package:yunzhixiao_customer_client/commons/nets/net_message.dart';
import 'package:yunzhixiao_customer_client/commons/routers/router.dart';
import 'package:yunzhixiao_customer_client/models/order.dart';
import 'package:yunzhixiao_customer_client/models/red_packet.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_model.dart';
import 'package:yunzhixiao_customer_client/service/order_repository.dart';

class ShopPaymentModel extends ViewStateModel {
  final int shopId;
  Order order;
  String promotionContent = "请选择红包/抵用券";
  RedPacket redPacket;

  ShopPaymentModel(this.shopId, context) {}

  refresh(context) async {
    setBusy();
    try {
      order = await OrderRepository.createOrder(this.shopId);
      setIdle();
    } catch (e, s) {
      setError(e, s);
      showErrorMessage(context);
      Navigator.pop(context);
    }
  }
  readOrderById(orderId) async {
    setBusy();
    try {
      order = await OrderRepository.readOrder(orderId);
      notifyListeners();
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }
  confirmOrder(context) async {
    print(order.payType);
    setBusy();
    try {
      await OrderRepository.updateOrder(order.id,
          pay_type: order.payType == "余额支付" ? 0 : 1,
          phoneNumber: order.phoneNum,
          remark: order.remark,
          promotions: redPacket?.id??null,
          pay_status: 1,
          pick_up_time_choice: order.pickUpTimeChoice,
          pick_up_type: order.pickUpType);
      order = await OrderRepository.readOrder(order.id);
      notifyListeners();
      setIdle();
      Future.microtask(() {
        showToast("支付成功！", context: context);
      });
      Navigator.pushReplacementNamed(context, RouteName.orderDetail,
          arguments: order.id);
    } catch (e, s) {
      setError(e, s);
      showErrorMessage(context);
      setIdle();
    }
  }
}

class OrderDetailModel extends ViewStateModel {
  final int orderId;
  Order order;
  String orderCancelReason;
  String orderCancelMoreReason;

  OrderDetailModel(this.orderId) {
//    refresh();
  }

  refresh() async {
    setBusy();
    try {
      order = await OrderRepository.readOrder(orderId);
      notifyListeners();
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }

  confirmOrderCancel(context) async {
    setBusy();
    try {
      if (orderCancelMoreReason == null){
        orderCancelMoreReason = "无";
      }
      await OrderRepository.createOrderRefund(orderId, orderCancelReason, orderCancelMoreReason);
      setIdle();
      Future.microtask(() {
        showToast("申请提交成功！", context: context);
      });
      Navigator.pop(context);
    } catch (e, s) {
      setError(e, s);
      showErrorMessage(context);
    }
  }
}
