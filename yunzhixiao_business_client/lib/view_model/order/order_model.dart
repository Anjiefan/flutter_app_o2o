import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yunzhixiao_business_client/commons/constants/config.dart';
import 'package:yunzhixiao_business_client/commons/managers/storage_manager.dart';
import 'package:yunzhixiao_business_client/models/order.dart';
import 'package:yunzhixiao_business_client/providers/view_state_refresh_list_model.dart';
import 'package:yunzhixiao_business_client/providers/view_state_refresh_list_with_date_filter.dart';
import 'package:yunzhixiao_business_client/service/test_repository.dart';
import 'package:yunzhixiao_business_client/service/order_repository.dart';
import 'package:yunzhixiao_business_client/view_model/order/order_home_info_model.dart';

class OrderListModel extends ViewStateRefreshListDateFilterModel {
  OrderHomeInfoModel orderHomeInfoModel;
  String ordering;
  String commodity_status;
  String service_number;
  String search;
  bool isSearch = false;
  int status = 1;
  Order order;
  OrderListModel(
      {this.ordering, this.commodity_status, this.search, this.service_number, this.status});
  @override
  Future<List> loadData({int pageNum}) async {
    return await OrderRepository.fetchOrders(pageNum,
        ordering: ordering,
        search: search,
        year: this.year,
        month: this.month,
        day: this.day,
        commodity_status: commodity_status,
        service_number: service_number);
  }
  loadOrderDetail(orderid) async {
    setBusy();
    this.order= await OrderRepository.fetchOrderDetail(orderid);
    setIdle();
  }
  @override
  initData() {
    // TODO: implement initData
    return super.initData();
  }

  clear(){
    this.list = [];
  }

  @override
  onCompleted(List data) {
    return super.onCompleted(data);
  }
  //商家操作一共有：7种，与传递状态commodity_status对应
  //同意接单： commodity_status=0
  //拒绝接单： commodity_status=5
  //完成备餐： commodity_status=1
  //完成取餐： commodity_status=4
  //收到催单： commodity_status=0
  //同意取消： commodity_status=5
  //拒绝取消： commodity_status=0

  //接单
  reciveOrder(id, context) async {
    this.updateOrder(id, 0, context, '接单成功');
  }

  //拒单
  refuseOrder(id, context) async {
    this.updateOrder(id, 5, context, '拒绝接单');
  }

  //完成备餐
  waitingTakeOrder(id, context) async {
    this.updateOrder(id, 1, context, '已完成备餐');
  }

  //完成取餐
  archiveTakeOrder(id, context) async {
    this.updateOrder(id, 4, context, '已完成取餐，订单结束');
  }

  //收到催单
  reviceUrgent(id, context) async {
    this.updateOrder(id, 0, context, '收到催单，回复用户成功');
  }

  //同意取消
  agreeCancel(id, context) async {
    this.updateOrder(id, 5, context, '同意取消，订单结束');
  }

  //拒绝取消
  refuseCancel(id, context) async {
    this.updateOrder(id, 0, context, '拒绝取消，订单进入等待备餐状态');
  }

  updateOrder(id, commodity_status, context, text) async {
    try {
      await OrderRepository.updateOrder(id, commodity_status: commodity_status);
      
      if (orderHomeInfoModel != null) {
        print("!!!!!!orderHomeInfoModel.refresh()");
        orderHomeInfoModel.refresh();
      } else {
        print("!!!!!!orderHomeInfoModel is null");
      }
      Future.microtask(() {
        showToast(text);
      });
    } catch (e) {
      Future.microtask(() {
        showToast(e.response.data[0]);
      });
    }
    this.refresh();
  }

  searchOrder(String search) {
    this.search = search;
    this.year=null;
    this.month=null;
    this.day=null;
    this.refresh();
  }
  searchOrderByServiceNum(String service_number){
    this.service_number=service_number;
    this.year=null;
    this.month=null;
    this.day=null;
    this.refresh();
  }
}

class DoingOrderModel extends OrderListModel{
  Future<List> loadData({int pageNum}) async {
    return await OrderRepository.fetchOrders(pageNum,
        commodity_status: "0,1",
      year: this.year,
      month: this.month,
      day: this.day,
    );
  }
  DoingOrderModel(){
    var isLogin =  StorageManager.sharedPreferences.getBool(Config.IS_LOGIN_KEY);
    if(isLogin==true){
      initData();
    }
  }
}

class ArchiveOrderModel extends OrderListModel{
  Future<List> loadData({int pageNum}) async {
    return await OrderRepository.fetchOrders(pageNum,
        commodity_status: "4",
      year: this.year,
      month: this.month,
      day: this.day,
    );
  }
  ArchiveOrderModel(){
    var isLogin =  StorageManager.sharedPreferences.getBool(Config.IS_LOGIN_KEY);
    if(isLogin==true){
      initData();
    }
  }
}

class LazyOrderModel extends OrderListModel{
  Future<List> loadData({int pageNum}) async {
    return await OrderRepository.fetchOrders(pageNum,
        commodity_status: "6",
      year: this.year,
      month: this.month,
      day: this.day,
    );
  }
  LazyOrderModel(){
    var isLogin =  StorageManager.sharedPreferences.getBool(Config.IS_LOGIN_KEY);
    if(isLogin==true){
      initData();
    }
  }
}

class CancelOrderModel extends OrderListModel{
  Future<List> loadData({int pageNum}) async {
    return await OrderRepository.fetchOrders(pageNum,
        commodity_status: "5",
        year: this.year,
        month: this.month,
        day: this.day,
    );
  }
  CancelOrderModel(){
    var isLogin =  StorageManager.sharedPreferences.getBool(Config.IS_LOGIN_KEY);
    if(isLogin==true){
      initData();
    }
  }
}


class NewOperateOrder extends OrderListModel{
  static const int pageSize = 200;
  Future<List> loadData({int pageNum}) async {
    return await OrderRepository.fetchBriefOrders(pageNum,
      commodity_status: "-1",
    );
  }
  NewOperateOrder(){
    var isLogin =  StorageManager.sharedPreferences.getBool(Config.IS_LOGIN_KEY);
    if(isLogin==true){
      initData();
    }
  }
}

class WaitOperateOrder extends OrderListModel{
  static const int pageSize = 200;
  Future<List> loadData({int pageNum}) async {
    return await OrderRepository.fetchBriefOrders(pageNum,
      commodity_status: "0",
    );
  }
  WaitOperateOrder(){
    var isLogin =  StorageManager.sharedPreferences.getBool(Config.IS_LOGIN_KEY);
    if(isLogin==true){
      initData();
    }
  }
}

class TakeOperateOrder extends OrderListModel{
  static const int pageSize = 200;
  Future<List> loadData({int pageNum}) async {
    return await OrderRepository.fetchBriefOrders(pageNum,
      commodity_status: "1",
    );
  }
  TakeOperateOrder(){
    var isLogin =  StorageManager.sharedPreferences.getBool(Config.IS_LOGIN_KEY);
    if(isLogin==true){
      initData();
    }
  }
}

class UrgeOperateOrder extends OrderListModel{
  static const int pageSize = 200;
  Future<List> loadData({int pageNum}) async {
    return await OrderRepository.fetchBriefOrders(pageNum,
      commodity_status: "2",
    );
  }
  UrgeOperateOrder(){
    var isLogin =  StorageManager.sharedPreferences.getBool(Config.IS_LOGIN_KEY);
    if(isLogin==true){
      initData();
    }
  }
}

class CancelOperateOrder extends OrderListModel{
  Future<List> loadData({int pageNum}) async {
    return await OrderRepository.fetchBriefOrders(pageNum,
      commodity_status: "3",
    );
  }
  CancelOperateOrder(){
    var isLogin =  StorageManager.sharedPreferences.getBool(Config.IS_LOGIN_KEY);
    if(isLogin==true){
      initData();
    }
  }
}