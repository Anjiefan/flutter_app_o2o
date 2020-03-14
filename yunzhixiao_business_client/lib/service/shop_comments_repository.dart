import 'package:yunzhixiao_business_client/commons/nets/http.dart';
import 'package:yunzhixiao_business_client/models/shop_comment.dart';

class ShopCommentsRepository{
  static Future fetchComments(int pageNum, int isGood) async {
    var response = await http.netFetch('shop_comments/',params:{
      'page':pageNum==null?1:pageNum,
      'is_good':isGood==null?1:isGood,
    },method: 'get');
    return ShopComment.fromJson(response.data).data;
  }
}