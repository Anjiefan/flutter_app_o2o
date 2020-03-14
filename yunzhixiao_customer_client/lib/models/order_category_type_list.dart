
import 'package:yunzhixiao_customer_client/models/order_category_type.dart';

class CategoryTypeList {
  List<CategoryType> data;

  CategoryTypeList({this.data});

  CategoryTypeList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<CategoryType>();
      json['data'].forEach((v) {
        data.add(new CategoryType.fromJson(v));
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