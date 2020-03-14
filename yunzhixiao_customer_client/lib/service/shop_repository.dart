import 'package:yunzhixiao_customer_client/commons/nets/http.dart';
import 'package:yunzhixiao_customer_client/models/cart_info.dart';
import 'package:yunzhixiao_customer_client/models/locked_shop.dart';
import 'package:yunzhixiao_customer_client/models/order_category_type_list.dart';
import 'package:yunzhixiao_customer_client/models/order_list.dart';
import 'package:yunzhixiao_customer_client/models/shop.dart';
import 'package:yunzhixiao_customer_client/models/shop_comment.dart';
import 'package:yunzhixiao_customer_client/models/shop_commodity_list.dart';
import 'package:yunzhixiao_customer_client/models/shop_type_cat_list.dart';

class ShopRepository {
  static Future fetchShopCommentsList(int pageNum,
      {int isGood, int shop}) async {
    Map<String, dynamic> data = {};
    if (isGood != null) {
      data["is_good"] = isGood;
    }
    if (shop != null) {
      data["shop"] = shop;
    }
    pageNum == null ? data["page"] = 1 : data["page"] = pageNum;
    var response =
        await http.netFetch('shop_comments/', params: data, method: 'get');
    return ShopComment.fromJson(response.data).data;
  }

  static Future fetchCommodityCommentsList(int pageNum,
      {int isGood, int commodity}) async {
    Map<String, dynamic> data = {};
    if (isGood != null) {
      data["is_good"] = isGood;
    }
    if (commodity != null) {
      data["commodity"] = commodity;
    }
    pageNum == null ? data["page"] = 1 : data["page"] = pageNum;

    var response =
        await http.netFetch('commodity_comments/', params: data, method: 'get');
    return CommodityCommentList.fromJson(response.data).data;
  }

  static Future fetchShopDetail(int shopId) async {
    var response = await http.netFetch('shops/$shopId/', method: 'get');
    return Shop.fromJson(response.data);
  }

  static Future fetchShopList(int pageNum,
      {String ordering,
      int hasLockCustomerFirstPay,
      int hasLockCustomer,
      int hasInviteCustomer,
      int hasMoneyOff,
      String search,
      int fatherId,
      int type}) async {
    Map<String, dynamic> data = {
      'pageNum': pageNum == null ? 1 : pageNum,
      'ordering': ordering
    };
    if (hasLockCustomerFirstPay != 0) {
      data["has_lock_customer_first_pay"] = 1;
    }
    if (hasLockCustomer != 0) {
      data["has_lock_customer"] = 1;
    }
    if (hasInviteCustomer != 0) {
      data["has_invite_customer"] = 1;
    }
    if (hasMoneyOff != 0) {
      data["has_money_off"] = 1;
    }
    if (search != null) {
      data["search"] = search;
    }
    if (fatherId != null) {
      data["father_type"] = fatherId;
    }
    if (type != null) {
      data["type"] = type;
    }
    var response = await http.netFetch('shops/', params: data, method: 'get');
    return ShopList.fromJson(response.data).data;
  }

  static Future fetchShareShopList(int pageNum) async {
    var response = await http.netFetch('share_shops/',
        params: {
          'pageNum': pageNum == null ? 1 : pageNum,
        },
        method: 'get');
    return ShopList.fromJson(response.data).data;
  }

  static Future fetchLockedShop() async {
    var response =
        await http.netFetch('user_shop_locked/', params: {}, method: 'get');
    return LockedShopList.fromJson(response.data).data;
  }

  static Future fetchShopTypeCatList(int pageNum, {int fatherId}) async {
    var response = await http.netFetch('shop_type_cat/',
        params: {
//      "category_type": categoryType,
          "father_type": fatherId
        },
        method: 'get');
    return ShopTypeCatList.fromJson(response.data).data;
  }

  static Future fetchShopCommodityTypeList(int shopId) async {
    var response = await http.netFetch('shop_commodities/',
        params: {'shop': shopId}, method: 'get');
    return ShopCommodityList.fromJson(response.data).types;
  }

  static Future fetchShopCommodityInfoList(int shopId) async {
    var response = await http.netFetch('shop_commodities/',
        params: {'shop': shopId}, method: 'get');
    return ShopCommodityList.fromJson(response.data).commodity;
  }

  static Future createShopCommodityInfoList(
      {int is_good, int order_id, String order_model, String message}) async {
    var data = {
      'is_good': is_good,
      'order_id': order_id,
      'order_model': order_model,
      'content': message,
    };
    var response =
        await http.netFetch('shop_comments/', params: data, method: 'post');

    return response.data;
  }

  static Future fetchCartInfoSelf(int shopId) async {
    var response =
        await http.netFetch('cart/self/?shop_id=${shopId}', method: 'get');
    return CartInfo.fromJson(response.data);
  }

  static Future fetchCartInfoList() async {
    var response = await http.netFetch('cart/', method: 'get');
    return CartInfoList.fromJson(response.data).data;
  }

  static Future clearCartInfo({int shopId}) async {
    Map<String, dynamic> data = {};
    if (shopId != null) {
      data["shop_id"] = shopId;
    }
    var response =
        await http.netFetch('cart/clear/', method: 'get', params: data);
    return response.data;
  }

  static Future updateCartItemNum(
      int shopId, int commodityId, int quantityDiffer) async {
    assert(quantityDiffer != 1 || quantityDiffer != -1);
    var response = await http
        .netFetch('cart/self/?shop_id=${shopId}', method: 'put', params: {
      "cart_commodity_cart_relate": [
        {"commodity_id": commodityId, "quantity": quantityDiffer}
      ]
    });
    return response;
  }

  static Future fetchCartNum() async {
    var response = await http.netFetch('cart_num/', method: 'get');
    return CartNum.fromJson(response.data);
  }
}
