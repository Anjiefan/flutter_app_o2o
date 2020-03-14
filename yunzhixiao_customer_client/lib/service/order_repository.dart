import 'package:yunzhixiao_customer_client/commons/nets/http.dart';
import 'package:yunzhixiao_customer_client/models/order.dart';
import 'package:yunzhixiao_customer_client/models/order_list.dart';
import 'package:yunzhixiao_customer_client/models/order_num.dart';
import 'package:yunzhixiao_customer_client/models/pay_order.dart';

class OrderRepository {
  static Future fetchOrders(int pageNum,
      {bool is_comment,
      bool is_after_sell,
      commodity_status,
      int status}) async {
    var data = {
      'page': pageNum == null ? '1' : pageNum.toString(),
    };
    if (is_comment != null) {
      data['is_comment'] = is_comment.toString();
    }
    if (is_after_sell != null) {
      data['is_after_sell'] = is_after_sell.toString();
    }
    if (commodity_status != null) {
      data['commodity_status'] = commodity_status.toString();
    }
    if (status != null) {
      data['status'] = status.toString();
    }
    var response = await http.netFetch('customer_get_orders/',
        params: data, method: 'get');

    return OrderList.fromJson(response.data).data;
  }

  static Future updateOrder(int id,
      {commodity_status,
      pay_type,
      pay_status,
      promotions,
      remark,
      phoneNumber,
      pick_up_type,
      pick_up_time_choice}) async {
    var data = {};
    if (commodity_status != null) {
      data['commodity_status'] = commodity_status.toString();
    }
    if (pay_type != null) {
      data['pay_type'] = pay_type.toString();
    }
    if (pay_status != null) {
      data['pay_status'] = pay_status.toString();
    }
    if (promotions != null) {
      data['promotions'] = promotions.toString();
    }
    if (remark != null) {
      data['remark'] = remark;
    }
    if (phoneNumber != null) {
      data["phone_number"] = phoneNumber;
    }
    if (pick_up_type != null) {
      data["pick_up_type"] = pick_up_type;
    }
    if (pick_up_time_choice != null) {
      data["pick_up_time_choice"] = pick_up_time_choice;
    }

    var response = await http.put('customer_get_orders/$id/', data: data);
    return response.data;
  }

  static Future createOrder(int shopId) async {
    var response = await http.netFetch('customer_get_orders/',
        params: {"shop": shopId}, method: 'post');
    return Order.fromJson(response.data);
  }

  static Future readOrder(int orderId) async {
    var response =
        await http.netFetch('customer_get_orders/$orderId/', method: 'get');
    return Order.fromJson(response.data);
  }

  static Future createPayOrder(double campus_code) async {
    var response = await http.netFetch('pay_orders/',
        params: {'campus_code': campus_code}, method: 'post');
    return PayCreateOrder.fromJson(response.data);
  }

  static Future readPayOrder(int id) async {
    var response = await http.netFetch('pay_orders/${id}/', method: 'get');
    return PayReadOrder.fromJson(response.data);
  }

  static Future createOrderRefund(
      int id, String reason, String reasonMore) async {
    var response = await http.netFetch('consumer_order_refund/',
        params: {
          'order_id': id,
          'order_model': 'GetOrder',
          'reason': reason,
          'detail_reason': reasonMore
        },
        method: 'post');
    return response.data;
  }

  static Future fetchOrderNum() async {
    var response = await http.netFetch('custom_order_num/', method: 'get');
    return OrderNum.fromJson(response.data);
  }
}
