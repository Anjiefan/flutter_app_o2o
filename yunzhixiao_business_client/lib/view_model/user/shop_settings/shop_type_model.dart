import 'package:yunzhixiao_business_client/providers/view_state_refresh_list_model.dart';
import 'package:yunzhixiao_business_client/service/shop_type_repository.dart';
class ShopTypeListModel extends ViewStateRefreshListModel{

  @override
  Future<List> loadData({int pageNum}) async{
    var all_types = await ShopTypeRepository.fetchShopTypes(pageNum);
      return all_types["data"];
    }

  @override
  initData(){
    return super.initData();
  }
  @override
  onCompleted(List data) {
    return super.onCompleted(data);
  }
}