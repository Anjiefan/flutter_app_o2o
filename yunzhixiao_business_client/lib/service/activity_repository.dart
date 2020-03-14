
import 'package:yunzhixiao_business_client/commons/nets/http.dart';
import 'package:yunzhixiao_business_client/models/discount_promotion_list.dart';
import 'package:yunzhixiao_business_client/models/red_packet_promotion_list.dart';
import 'package:yunzhixiao_business_client/models/money_off_promotion_list.dart';

class ActivityRepository {
  static Future fetchMoneyOffPromotions() async {
    var response = await http.netFetch('money_off_promotion/', method: 'get');
    return MoneyOffPromotionList
        .fromJson(response.data)
        .data;
  }

  static Future updateMoneyOffPromotions(
      {String resultStr, int status, int id}) async {
    var response = await http.netFetch('money_off_promotion/$id/',
        params: {"status": status, "price_between": resultStr}, method: 'put');
    return response.data;
  }

  static Future createMoneyOffPromotions({String resultStr, int status}) async {
    var response = await http.netFetch('money_off_promotion/',
        params: {"status": status, "price_between": resultStr}, method: 'post');
    return response.data;
  }

  static Future fetchLockCustomerFirstPayPromotions() async {
    var response = await http.netFetch(
        'lock_customer_first_pay_promotion/', method: 'get');
    return RedPacketPromotionList
        .fromJson(response.data)
        .data;
  }

  static updateLockCustomerFirstPayPromotions(double discountPrice, int status,
      int id) async {
    await http.netFetch('lock_customer_first_pay_promotion/$id/', params: {
      'status': status,
      'discount_price': discountPrice
    }, method: 'put');
  }

  static Future createLockCustomerFirstPayPromotion(double discountPrice,
      int status) async {
    await http.netFetch('lock_customer_first_pay_promotion/',
        params: {"status": status, "discount_price": discountPrice},
        method: 'post');
  }

  static Future fetchInviteCustomerPromotions() async {
    var response = await http.netFetch(
        'invite_customer_promotion/', method: 'get');
    return RedPacketPromotionList
        .fromJson(response.data)
        .data;
  }

  static updateInviteCustomerPromotions(double discountPrice, int status,
      int id) async {
    await http.netFetch('invite_customer_promotion/$id/', params: {
      'status': status,
      'discount_price': discountPrice
    }, method: 'put');
  }

  static Future createInviteCustomerPromotion(double discountPrice,
      int status) async {
    await http.netFetch('invite_customer_promotion/',
        params: {"status": status, "discount_price": discountPrice},
        method: 'post');
  }

  static Future fetchDiscountPromotions() async {
    var response = await http.netFetch(
        'lock_customer_promotion/', method: 'get');
    return DiscountPromotionList
        .fromJson(response.data)
        .data;
  }

  static updateDiscountPromotions(double discount, int status,
      int id) async {
    await http.netFetch('lock_customer_promotion/$id/', params: {
      'status': status,
      'discount': discount
    }, method: 'put');
  }

  static Future createDiscountPromotion(double discount,
      int status) async {
    await http.netFetch('lock_customer_promotion/',
        params: {"status": status, "discount": discount},
        method: 'post');
  }


}