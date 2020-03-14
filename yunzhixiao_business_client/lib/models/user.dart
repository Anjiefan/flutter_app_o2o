import 'package:yunzhixiao_business_client/models/shop.dart';
import 'package:yunzhixiao_business_client/models/withdraw_account.dart';

class User {
  Shop shop;
  Withdrawaccount withdrawaccount;
  String username;
  int id;
  var timeCode;
  var campusCode;

  User(
      {this.shop, this.username, this.id, this.timeCode, this.campusCode, this.withdrawaccount});

  User.fromJson(Map<String, dynamic> json) {
    shop = json['shop'] != null ? new Shop.fromJson(json['shop']) : null;
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
