import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yunzhixiao_customer_client/models/shop.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_model.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_refresh_list_model.dart';
import 'package:yunzhixiao_customer_client/service/shop_repository.dart';

class ShopListModel extends ViewStateRefreshListModel{

  final int fatherId;
  

  String ordering = '-sort_level';
  bool isSearch = false;
  //首单优惠
  int hasLockCustomerFirstPay = 0;
  //锁客折扣
  int hasLockCustomer = 0;
  //分享红包
  int hasInviteCustomer = 0;
  //满减促销
  int hasMoneyOff = 0;

  int type;

  String search;

  ShopListModel({this.fatherId,bool loading=true}){
    if(loading==true){
      initData();
    }

  }
  baseInitData({bool busy=false}) async {
    if(busy==true){
      setBusy();
    }
    this.list=await loadData();
    if(busy==true){
      setIdle();
    }
  }
  @override
  Future<List> loadData({int pageNum}) async{
    return await ShopRepository.fetchShopList(pageNum, ordering: ordering,
    hasLockCustomerFirstPay: hasLockCustomerFirstPay,
    hasLockCustomer: hasLockCustomer,
    hasInviteCustomer: hasInviteCustomer,
    hasMoneyOff: hasMoneyOff,
    search: search,
    fatherId: fatherId,
    type: type
    );
  }
  @override
  initData() {
    return super.initData();
  }
  @override
  onCompleted(List data) {
    return super.onCompleted(data);
  }

  onRefreshOrdering(ordering){
    this.ordering = ordering;
    this.refresh();
  }

  onRefreshType(type){
    this.type = type;
    this.refresh();
  }

}

class ShopCommentListModel extends ViewStateRefreshListModel{
  int isGood;
  final int shopId;
  ShopCommentListModel(this.shopId);
  @override
  Future<List> loadData({int pageNum}) async{
    return await ShopRepository.fetchShopCommentsList(pageNum, isGood: this.isGood, shop: this.shopId);
  }
  @override
  initData() {
    return super.initData();
  }
  @override
  onCompleted(List data) {
    return super.onCompleted(data);
  }

  onRefreshIsGood(isGood){
    this.isGood = isGood;
    this.refresh();
  }

  comment({int shop_user,
    int is_good,int order_id
    ,String order_model,String message,BuildContext context,var model} ) async {

    try {
      if(message==''){
        if(is_good==1){
          message='默认好评';
        }else{
          message='默认差评';
        }
      }
      setBusy();
      await ShopRepository.createShopCommodityInfoList(
          is_good: is_good,order_id: order_id,order_model: order_model,message: message);
      Future.microtask(() {
        showToast('评论成功', context: context,position: ToastPosition.bottom);
      });
    } catch (e) {
      showErrorByResponse(e,context);
    }
    await model.refresh();
    setIdle();
  }
}

class CommodityCommentListModel extends ViewStateRefreshListModel{
  int isGood;
  final int commodityId;
  CommodityCommentListModel(this.commodityId);
  @override
  Future<List> loadData({int pageNum}) async{
    return await ShopRepository.fetchCommodityCommentsList(pageNum, isGood: this.isGood, commodity: this.commodityId);
  }
  @override
  initData() {
    return super.initData();
  }
  @override
  onCompleted(List data) {
    return super.onCompleted(data);
  }

  onRefreshIsGood(isGood){
    this.isGood = isGood;
    this.refresh();
  }

  comment({int shop_user,
    int is_good,int order_id
    ,String order_model,String message,BuildContext context,var model} ) async {

    try {
      if(message==''){
        if(is_good==1){
          message='默认好评';
        }else{
          message='默认差评';
        }
      }
      setBusy();
      await ShopRepository.createShopCommodityInfoList(
          is_good: is_good,order_id: order_id,order_model: order_model,message: message);
      Future.microtask(() {
        showToast('评论成功', context: context,position: ToastPosition.bottom);
      });
    } catch (e) {
      showErrorByResponse(e,context);
    }
    await model.refresh();
    setIdle();
  }
}

class ShopDetailModel extends ViewStateModel {
  Shop shop;
  int shopId;
  ShopDetailModel(int shopId) {
    this.shopId = shopId;
  }

  refresh() async {
    setBusy();
    try {
      shop = await ShopRepository.fetchShopDetail(shopId);
      notifyListeners();
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }
}
