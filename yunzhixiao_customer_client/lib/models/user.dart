import 'package:yunzhixiao_customer_client/models/shop.dart';
import 'package:yunzhixiao_customer_client/models/shop_locked_list.dart';
import 'package:yunzhixiao_customer_client/models/withdraw_account.dart';

class User {
  Userinfo userinfo;
  ShopList shop;
  String username;
  int id;
  var timeCode;
  var campusCode;
  Withdrawaccount withdrawaccount;

  User(
      {this.userinfo,
        this.shop,
        this.username,
        this.id,
        this.timeCode,
        this.campusCode,
        this.withdrawaccount});

  User.fromJson(Map<String, dynamic> json) {
    userinfo = json['userinfo'] != null
        ? new Userinfo.fromJson(json['userinfo'])
        : null;
    shop = json['shop'] != null ? new ShopList.fromJson(json['shop']) : null;
    username = json['username'];
    id = json['id'];
    timeCode = json['time_code'];
    campusCode = json['campus_code'];
    withdrawaccount = json['withdrawaccount'] != null
        ? new Withdrawaccount.fromJson(json['withdrawaccount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userinfo != null) {
      data['userinfo'] = this.userinfo.toJson();
    }
    if (this.shop != null) {
      data['shop'] = this.shop.toJson();
    }
    data['username'] = this.username;
    data['id'] = this.id;
    data['time_code'] = this.timeCode;
    data['campus_code'] = this.campusCode;
    if (this.withdrawaccount != null) {
      data['withdrawaccount'] = this.withdrawaccount.toJson();
    }
    return data;
  }
}