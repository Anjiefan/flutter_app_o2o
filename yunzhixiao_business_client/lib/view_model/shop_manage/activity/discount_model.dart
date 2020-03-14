import 'package:oktoast/oktoast.dart';
import 'package:yunzhixiao_business_client/models/discount_promotion_list.dart';
import 'package:yunzhixiao_business_client/models/red_packet_promotion_list.dart';
import 'package:yunzhixiao_business_client/providers/view_state_model.dart';
import 'package:yunzhixiao_business_client/service/activity_repository.dart';
class DiscountModel extends ViewStateModel {

  DiscountPromotion _promotion;
  DiscountPromotion get promotion => _promotion;

  DiscountModel(){
    refresh();
  }

  void refresh() {
    setBusy();
    ActivityRepository.fetchDiscountPromotions().then((value){
      if (value.length == 1){
        var item = value[0];
        _promotion = item != null ? item : DiscountPromotion(
            status: "启动", discountPrice: 0
        );
      }else{
        _promotion = DiscountPromotion(
            status: "启动", discountPrice: 0
        );
      }
      setIdle();
    });
  }

  Future<bool> updateDiscountPromotion(context) async {
    setBusy();
    try {
      await ActivityRepository.updateDiscountPromotions(promotion.discountPrice, promotion.status == "启动"? 1: 0, promotion.id);
      Future.microtask(() {
        showToast("修改规则成功！");
      });
      setIdle();
      return true;
    } catch (e, s) {
      setError(e,s);
      Future.microtask(() {
        showToast(e.response.data["info"], context: context);
      });
      return false;
    }
  }

  Future<bool> createDiscountPromotion(context) async {
    setBusy();
    try {
      await ActivityRepository.createDiscountPromotion(promotion.discountPrice, promotion.status == "启动"? 1: 0);
      Future.microtask(() {
        showToast("创建规则成功！");
      });
      refresh();
      return true;
    } catch (e, s) {
      setError(e,s);
      Future.microtask(() {
        showToast(e.response.data["info"], context: context);
      });
      return false;
    }
  }




}
