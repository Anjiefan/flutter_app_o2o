import 'package:yunzhixiao_business_client/models/commodity.dart';
import 'package:yunzhixiao_business_client/models/commodity_type.dart';
import 'package:yunzhixiao_business_client/providers/view_state_refresh_list_model.dart';
import 'package:yunzhixiao_business_client/service/commodity_repository.dart';
import 'package:yunzhixiao_business_client/view_model/shop_manage/commodity/commodity_model.dart';

class CommodityTypeModel extends ViewStateRefreshListModel {
  CommodityModel commodityModel;

  CommodityType _selectedCommodityType;
  int _selectedCommodityStatus = null;

  CommodityTypeModel();

  CommodityType get selectedCommodityType => _selectedCommodityType;

  int get selectedCommodityStatus => _selectedCommodityStatus;

  onSelectedCommodityType(
      {CommodityType commodityType, int index, bool sort = false, bool isInit = false}) {
    _selectedCommodityType = commodityType;
    if (sort && !isInit) {
      updateCommodityOrdering();
    } else {
      this.refresh();
      if (commodityModel != null) {
        commodityModel.refresh();
      }
    }
  }

  void updateCommodityOrdering() {
    commodityModel.isFirstTime = true;
    String ids = "";
    for (int i = 0; i < commodityModel.displayItemList.length; i++) {
      ids += commodityModel.displayItemList[i].id.toString();
      if (i != commodityModel.displayItemList.length - 1) {
        ids += ",";
      }
    }
    CommodityRepository.updateCommodityOrdering(ids).then((value) {
      this.refresh();
      if (commodityModel != null) {
        commodityModel.refresh();
      }
    });
  }

  onSelectedCommodityStatus(int status) {
    _selectedCommodityStatus = status;
    this.refresh();
    if (commodityModel != null) {
      commodityModel.refresh();
    }
  }

  onInitializeCommodityModel(model) {
    this.commodityModel = model;
  }

  @override
  Future<List> loadData({int pageNum}) async {
    return await CommodityRepository.fetchCommodityType(pageNum);
  }

  @override
  initData() {
    return super.initData();
  }

  @override
  onCompleted(List data) {
    return super.onCompleted(data);
  }
}
