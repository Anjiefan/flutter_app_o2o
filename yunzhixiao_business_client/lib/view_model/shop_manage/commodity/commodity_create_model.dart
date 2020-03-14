import 'package:oktoast/oktoast.dart';
import 'package:yunzhixiao_business_client/models/commodity.dart';
import 'package:yunzhixiao_business_client/models/commodity_type.dart';
import 'package:yunzhixiao_business_client/models/discount_promotion_list.dart';
import 'package:yunzhixiao_business_client/models/red_packet_promotion_list.dart';
import 'package:yunzhixiao_business_client/providers/view_state_model.dart';
import 'package:yunzhixiao_business_client/service/activity_repository.dart';
import 'package:yunzhixiao_business_client/service/commodity_repository.dart';
class CommodityCreateModel extends ViewStateModel {
  Commodity _commodity;
  Commodity get commodity => _commodity;
  CommodityType _commodityType;
  CommodityType get commodityType => _commodityType;

  CommodityCreateModel(){
    refresh();
  }

  void refresh() {
    setBusy();
    _commodity = Commodity(
      name: "", img: "", price: 0.0, status: 1
    );
    setIdle();
  }

  onSelectedCommodityType(commodityType) {
    _commodityType = commodityType;
  }

  Future<bool> createCommodity(context) async {
    setBusy();
    try {
      await CommodityRepository.createCommodity(commodity.img, commodity.name, commodity.price, commodityType.id);
      Future.microtask(() {
        showToast("商品创建成功！");
      });
      refresh();
      return true;
    } catch (e, s) {
      setError(e,s);
      this.showErrorMessage(context);
      return false;
    }
  }




}
