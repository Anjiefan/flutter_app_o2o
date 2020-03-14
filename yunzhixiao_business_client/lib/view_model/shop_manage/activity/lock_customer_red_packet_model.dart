import 'package:oktoast/oktoast.dart';
import 'package:yunzhixiao_business_client/models/red_packet_promotion_list.dart';
import 'package:yunzhixiao_business_client/providers/view_state_model.dart';
import 'package:yunzhixiao_business_client/service/activity_repository.dart';
class LockCustomerRedPacketModel extends ViewStateModel {

  RedPacketPromotion _promotion;
  RedPacketPromotion get promotion => _promotion;

  LockCustomerRedPacketModel(){
    refresh();
  }

  void refresh() {
    setBusy();
    ActivityRepository.fetchLockCustomerFirstPayPromotions().then((value){
      if (value.length == 1){
        var item = value[0];
        _promotion = item != null ? item : RedPacketPromotion(
            status: "启动", discountPrice: 0
        );
      }else{
        _promotion = RedPacketPromotion(
            status: "启动", discountPrice: 0
        );
      }
      setIdle();
    });
  }

  Future<bool> updateLockCustomerFirstPayPromotion(context) async {
    setBusy();
    try {
      await ActivityRepository.updateLockCustomerFirstPayPromotions(promotion.discountPrice, promotion.status == "启动"? 1: 0, promotion.id);
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

  Future<bool> createLockCustomerFirstPayPromotion(context) async {
    setBusy();
    try {
      await ActivityRepository.createLockCustomerFirstPayPromotion(promotion.discountPrice, promotion.status == "启动"? 1: 0);
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
