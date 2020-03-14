import 'package:yunzhixiao_business_client/commons/nets/http.dart';
import 'package:yunzhixiao_business_client/models/shop_comment.dart';
import 'package:yunzhixiao_business_client/models/shop_invite_data.dart';
import 'package:yunzhixiao_business_client/models/shop_locked_list.dart';

class ShopLockedRepository{

  static Future fetchShopLocked() async {
    var response = await http.netFetch('shop_locked/',params:{
      'page':1,
    },method: 'get');
    return ShopLockedList.fromJson(response.data);
  }

  static Future fetchShopLockedList(int pageNum) async {
    var response = await http.netFetch('shop_locked/',params:{
      'page':pageNum==null?1:pageNum,
    },method: 'get');
    return ShopLockedList.fromJson(response.data).data;
  }

  static Future fetchShopInviteData() async {
    var response = await http.netFetch('shop_invite_data/',params:{
    },method: 'get');
    return ShopInviteData.fromJson(response.data);
  }


}