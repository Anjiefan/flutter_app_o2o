import 'package:yunzhixiao_business_client/commons/nets/http.dart';
import 'package:yunzhixiao_business_client/models/shop_comment.dart';

class ShopTypeRepository{
  static Future fetchShopTypes(int pageNum) async {
    var response = await http.netFetch('shop_types/',params:{
      'page':pageNum==null?1:pageNum,
    },method: 'get');
    return response.data;
  }
}