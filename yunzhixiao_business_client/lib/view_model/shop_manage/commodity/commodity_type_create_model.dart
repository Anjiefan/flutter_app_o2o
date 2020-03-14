import 'package:oktoast/oktoast.dart';
import 'package:yunzhixiao_business_client/models/commodity.dart';
import 'package:yunzhixiao_business_client/models/commodity_type.dart';
import 'package:yunzhixiao_business_client/models/discount_promotion_list.dart';
import 'package:yunzhixiao_business_client/models/red_packet_promotion_list.dart';
import 'package:yunzhixiao_business_client/providers/view_state_model.dart';
import 'package:yunzhixiao_business_client/service/activity_repository.dart';
import 'package:yunzhixiao_business_client/service/commodity_repository.dart';
class CommodityTypeCreateModel extends ViewStateModel {

  String name;

  Future<bool> createCommodityType(context) async {
    setBusy();
    try {
      await CommodityRepository.createCommodityType(this.name);
      Future.microtask(() {
        showToast("分类创建成功！");
      });
      return true;
    } catch (e, s) {
      setError(e,s);
      this.showErrorMessage(context);
      return false;
    }
  }
}
