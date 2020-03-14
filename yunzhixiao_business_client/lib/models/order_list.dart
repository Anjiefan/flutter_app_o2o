import 'package:yunzhixiao_business_client/models/order.dart';

class OrderList {
  List<Order> data;

  OrderList({this.data});

  OrderList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Order>();
      json['data'].forEach((v) {
        data.add(new Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}