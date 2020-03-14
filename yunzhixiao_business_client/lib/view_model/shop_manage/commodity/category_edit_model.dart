import 'package:oktoast/oktoast.dart';
import 'package:yunzhixiao_business_client/models/commodity_type.dart';
import 'package:yunzhixiao_business_client/providers/view_state_model.dart';
import 'package:yunzhixiao_business_client/service/commodity_repository.dart';

class CategoryEditModel extends ViewStateModel {
  final int id;
  CommodityType commodityType;

  CategoryEditModel(this.id) {
    refresh();
  }

  void refresh() {
    setBusy();
    CommodityRepository.fetchCommodityTypeById(id).then((value) {
      if (value != null) {
        commodityType = value;
        setIdle();
      }
    });
  }

  Future<bool> updateCommodityType(context) async {
    setBusy();
    try {
      await CommodityRepository.updateCommodityType(id, commodityType.name);
      Future.microtask(() {
        showToast("分类修改成功！");
      });
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      this.showErrorMessage(context);
      return false;
    }
  }

    Future<bool> deleteCommodityType(context) async {
    setBusy();
    try {
      await CommodityRepository.deleteCommodityType(id);
      Future.microtask(() {
        showToast("分类删除成功！");
      });
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      this.showErrorMessage(context);
      return false;
    }
  }
}
