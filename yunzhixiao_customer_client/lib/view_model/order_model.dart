


import 'package:flutter/cupertino.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yunzhixiao_customer_client/commons/constants/config.dart';
import 'package:yunzhixiao_customer_client/commons/managers/storage_manager.dart';
import 'package:yunzhixiao_customer_client/commons/routers/router.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_refresh_list_model.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_refresh_list_with_date_filter.dart';
import 'package:yunzhixiao_customer_client/service/order_repository.dart';
abstract class OrderListModel extends ViewStateRefreshListDateFilterModel{
  @override
  Future<List> loadData({int pageNum}) async{}
  @override
  initData() {
    // TODO: implement initData
    return super.initData();
  }
  @override
  onCompleted(List data) {
    return super.onCompleted(data);
  }
  //用户与传递状态commodity_status对应操作一共有：3种，与传递状态commodity_status对应
  //申请取消/直接取消： commodity_status=3
  //申请催单： commodity_status=2
  //取消申请： commodity_status=0

  //完成支付
  askCancel(id,context, {needRefund = true}) async {
    this.updateOrder(id, 3, context,'申请取消订单');
  }
  //申请催单
  reminderOrder(id,context) async {
    this.updateOrder(id, 2, context,'申请催单');

  }
  //取消申请
  cancelAsk(id,context) async {
    this.updateOrder(id, 0, context,'取消申请');
  }

  payOrder(id,context,{pay_type,pay_status,promotions}) async{
    try {
      await OrderRepository.updateOrder(id, pay_type: pay_type,pay_status: pay_status,promotions: promotions);
      Future.microtask(() {
        showToast('支付成功', context: context);
      });
    } catch (e) {
      showErrorByResponse(e,context);
    }
    this.refresh();
  }




  updateOrder(id,commodity_status,BuildContext context,text) async {

    try {
      Future.microtask(() {
        showToast(text, context: context,position: ToastPosition.bottom);
      });
      setBusy();
      await OrderRepository.updateOrder(id, commodity_status: commodity_status);


    } catch (e) {
      showErrorByResponse(e,context);
    }
    await this.refresh();
    setIdle();
  }
}

class AllOrderListModel extends OrderListModel{
  AllOrderListModel(){
    var isLogin =  StorageManager.sharedPreferences.getBool(Config.IS_LOGIN_KEY);
    if(isLogin==true){
      initData();
    }

  }
  @override
  Future<List> loadData({int pageNum}) async{
    return await OrderRepository.fetchOrders(pageNum);
  }
}

class WaitingPayListModel extends OrderListModel{
  WaitingPayListModel(){
    var isLogin =  StorageManager.sharedPreferences.getBool(Config.IS_LOGIN_KEY);
    if(isLogin==true){
      initData();
    }

  }
  @override
  Future<List> loadData({int pageNum}) async{
    return await OrderRepository.fetchOrders(pageNum,status: 0);
  }
}

class WaitingReciveListModel  extends OrderListModel{
  WaitingReciveListModel(){
    var isLogin =  StorageManager.sharedPreferences.getBool(Config.IS_LOGIN_KEY);
    if(isLogin==true){
      initData();
    }

  }
  @override
  Future<List> loadData({int pageNum}) async{
    return await OrderRepository.fetchOrders(pageNum,commodity_status: 1);
  }
}

class AfterSellListModel  extends OrderListModel{
  AfterSellListModel(){
    var isLogin =  StorageManager.sharedPreferences.getBool(Config.IS_LOGIN_KEY);
    if(isLogin==true){
      initData();
    }

  }
  @override
  Future<List> loadData({int pageNum}) async{
    return await OrderRepository.fetchOrders(pageNum,commodity_status: 3);
  }
}
