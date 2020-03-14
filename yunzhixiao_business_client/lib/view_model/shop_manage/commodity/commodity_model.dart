import 'dart:collection';

import 'package:yunzhixiao_business_client/models/commodity.dart';
import 'package:yunzhixiao_business_client/models/commodity_type.dart';
import 'package:yunzhixiao_business_client/providers/view_state_refresh_list_model.dart';
import 'package:yunzhixiao_business_client/service/commodity_repository.dart';
import 'package:yunzhixiao_business_client/view_model/shop_manage/commodity/commodity_type_model.dart';

class CommodityModel extends ViewStateRefreshListModel {
  final CommodityTypeModel commodityTypeModel;
  bool isFirstTime = true;
  CommodityModel(this.commodityTypeModel);

  @override
  Future<List> loadData({int pageNum}) async {
    if(commodityTypeModel.selectedCommodityType!=null){
      var commodityList =  await CommodityRepository.fetchCommodity(pageNum,
          status: commodityTypeModel.selectedCommodityStatus,
          type: commodityTypeModel.selectedCommodityType.id);
      if (isFirstTime) {
        resetLists(commodityList);
        isFirstTime = false;
      }
      return commodityList;
    }
    else{
      return [];
    }

  }

  @override
  initData() {
    return super.initData();
  }

  @override
  onCompleted(List data) {
    return super.onCompleted(data);
  }

  updateStatus(int id,int status) async {
    setBusy();
    await CommodityRepository.updateCommodityStatus(id, status);
    this.refresh();
    if (commodityTypeModel != null){
      commodityTypeModel.refresh();
    }
    setIdle();
  }

  List displayItemList=[];

  void swapIndexes(int start, int current){
    var tmp = displayItemList[start];
    displayItemList.remove(tmp);


    displayItemList.insert(current, tmp);

    notifyListeners();
//    this.refresh();
//    this.commodityTypeModel.refresh();
  }

  void resetLists(commodityList) {
    displayItemList=[];
    for (int i = 0; i < commodityList.length; i++) {
      displayItemList.add(commodityList[i]);
    }
    this.refresh();
  }

}
