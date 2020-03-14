import 'package:yunzhixiao_customer_client/models/shop_type_cat_list.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_list_model.dart';
import 'package:yunzhixiao_customer_client/service/shop_repository.dart';

class ShopTypeCatModel extends ViewStateListModel<ShopTypeCat> {

  final int fatherId;

  ShopTypeCatModel(this.fatherId);
  @override
  Future<List<ShopTypeCat>> loadData() async {
    return await ShopRepository.fetchShopTypeCatList(1, fatherId: this.fatherId);
  }
}