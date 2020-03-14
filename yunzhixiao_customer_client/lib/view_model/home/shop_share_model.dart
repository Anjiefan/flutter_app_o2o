import 'package:yunzhixiao_customer_client/commons/constants/config.dart';
import 'package:yunzhixiao_customer_client/commons/managers/storage_manager.dart';
import 'package:yunzhixiao_customer_client/models/locked_shop.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_refresh_list_model.dart';
import 'package:yunzhixiao_customer_client/service/shop_repository.dart';

class ShopShareListModel extends ViewStateRefreshListModel{

  List<LockedShop> lockedShopList=[];

  @override
  Future<List> loadData({int pageNum}) async{
    lockedShopList=await ShopRepository.fetchLockedShop();
    return await ShopRepository.fetchShareShopList(pageNum);
  }
  @override
  initData() async {

    return super.initData();
  }
  ShopShareListModel()  {
    var isLogin =  StorageManager.sharedPreferences.getBool(Config.IS_LOGIN_KEY);
    if(isLogin==true){
      initData();
    }

  }

  @override
  onCompleted(List data) {
    return super.onCompleted(data);
  }



}