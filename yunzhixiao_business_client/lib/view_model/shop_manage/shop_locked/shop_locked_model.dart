import 'package:yunzhixiao_business_client/providers/view_state_refresh_list_model.dart';
import 'package:yunzhixiao_business_client/service/shop_comments_repository.dart';
import 'package:yunzhixiao_business_client/service/shop_locked_repository.dart';
class ShopLockedModel extends ViewStateRefreshListModel{
  ShopLockedModel();
  @override
  Future<List> loadData({int pageNum}) async{
    return await ShopLockedRepository.fetchShopLockedList(pageNum);
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