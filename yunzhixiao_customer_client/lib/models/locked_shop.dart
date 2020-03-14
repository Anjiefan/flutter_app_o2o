import 'package:yunzhixiao_customer_client/models/user.dart';

class LockedShopList {
  List<LockedShop> data;

  LockedShopList({this.data});

  LockedShopList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<LockedShop>();
      json['data'].forEach((v) {
        data.add(new LockedShop.fromJson(v));
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
class LockedShop {
  User user;
  int shop;

  LockedShop({this.user, this.shop});

  LockedShop.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    shop = json['shop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['shop'] = this.shop;
    return data;
  }
}