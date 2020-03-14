import 'package:yunzhixiao_customer_client/models/shop.dart';

import 'commodity.dart';

class ShopCommodityList {
  List<Types> types;
  Shop shop;
  List<Commodity> commodity;

  ShopCommodityList({this.types, this.shop, this.commodity});

  ShopCommodityList.fromJson(Map<String, dynamic> json) {
    if (json['types'] != null) {
      types = new List<Types>();
      json['types'].forEach((v) {
        types.add(new Types.fromJson(v));
      });
    }
    shop = json['shop'] != null ? new Shop.fromJson(json['shop']) : null;
    if (json['commodity'] != null) {
      commodity = new List<Commodity>();
      json['commodity'].forEach((v) {
        commodity.add(new Commodity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.types != null) {
      data['types'] = this.types.map((v) => v.toJson()).toList();
    }
    if (this.shop != null) {
      data['shop'] = this.shop.toJson();
    }
    if (this.commodity != null) {
      data['commodity'] = this.commodity.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Types {
  int id;
  int index;
  String name;
  String date;
  String updateDate;
  double ordering;
  int shop;
  int user;

  Types(
      {this.id,
        this.index,
        this.name,
        this.date,
        this.updateDate,
        this.ordering,
        this.shop,
        this.user});

  Types.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    index = json['index'];
    name = json['name'];
    date = json['date'];
    updateDate = json['update_date'];
    ordering = json['ordering'];
    shop = json['shop'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['index'] = this.index;
    data['name'] = this.name;
    data['date'] = this.date;
    data['update_date'] = this.updateDate;
    data['ordering'] = this.ordering;
    data['shop'] = this.shop;
    data['user'] = this.user;
    return data;
  }
}