import 'package:oktoast/oktoast.dart';
import 'package:yunzhixiao_business_client/models/commodity.dart';
import 'package:yunzhixiao_business_client/models/commodity_type.dart';
import 'package:yunzhixiao_business_client/models/discount_promotion_list.dart';
import 'package:yunzhixiao_business_client/models/red_packet_promotion_list.dart';
import 'package:yunzhixiao_business_client/providers/view_state_model.dart';
import 'package:yunzhixiao_business_client/service/activity_repository.dart';
import 'package:yunzhixiao_business_client/service/commodity_repository.dart';
class CommodityEditModel extends ViewStateModel {
  final int id;
  Commodity _commodity;
  Commodity get commodity => _commodity;
  CommodityType _commodityType;
  CommodityType get commodityType => _commodityType;

  CommodityEditModel(this.id){
    refresh();
  }

  void refresh() {
    setBusy();
    CommodityRepository.fetchCommodityById(id).then((value){
      if (value != null){
        _commodity = value;
        CommodityRepository.fetchCommodityTypeById(_commodity.type).then((value){
          _commodityType = value;
          setIdle();
        });
      }

    });
  }

  onSelectedCommodityType(commodityType) {
    _commodityType = commodityType;
  }

  Future<bool> updateCommodity(context) async {
    setBusy();
    try {
      await CommodityRepository.updateCommodity(commodity.img, commodity.name, commodity.price, commodityType.id, commodity.id);
      Future.microtask(() {
        showToast("商品信息修改成功！");
      });
      setIdle();
      return true;
    } catch (e, s) {
      setError(e,s);
      this.showErrorMessage(context);
      return false;
    }
  }

    Future<bool> deleteCommodity(context) async {
    setBusy();
    try {
      await CommodityRepository.deleteCommodity(commodity.id);
      Future.microtask(() {
        showToast("商品删除成功！");
      });
      setIdle();
      return true;
    } catch (e, s) {
      setError(e,s);
      this.showErrorMessage(context);
      return false;
    }
  }
}
