import 'package:yunzhixiao_business_client/models/shop.dart';
import 'package:yunzhixiao_business_client/models/withdraw_account.dart';

class ShopLockedList {
  List<ShopLocked> data;
  int num;

  ShopLockedList({this.data, this.num});

  ShopLockedList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<ShopLocked>();
      json['data'].forEach((v) {
        data.add(new ShopLocked.fromJson(v));
      });
    }
    num = json['num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['num'] = this.num;
    return data;
  }
}

class ShopLocked {
  Invite invite;

  ShopLocked({this.invite});

  ShopLocked.fromJson(Map<String, dynamic> json) {
    invite =
        json['invite'] != null ? new Invite.fromJson(json['invite']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.invite != null) {
      data['invite'] = this.invite.toJson();
    }
    return data;
  }
}

class Invite {
  Userinfo userinfo;
  Shop shop;
  String username;
  int id;
  var timeCode;
  var campusCode;
  Withdrawaccount withdrawaccount;

  Invite(
      {this.userinfo,
      this.shop,
      this.username,
      this.id,
      this.timeCode,
      this.campusCode,
      this.withdrawaccount});

  Invite.fromJson(Map<String, dynamic> json) {
    userinfo = json['userinfo'] != null
        ? new Userinfo.fromJson(json['userinfo'])
        : null;
    shop  = json['shop'] != null ? new Shop.fromJson(json['shop']) : null;
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

class Userinfo {
  int id;
  String sex;
  String headImg;
  String username;
  String wxJson;
  String phoneNum;
  String updateTime;
  String addTime;
  int user;

  Userinfo(
      {this.id,
      this.sex,
      this.headImg,
      this.username,
      this.wxJson,
      this.phoneNum,
      this.updateTime,
      this.addTime,
      this.user});

  Userinfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sex = json['sex'];
    headImg = json['head_img'];
    username = json['username'];
    wxJson = json['wx_json'];
    phoneNum = json['phone_num'];
    updateTime = json['update_time'];
    addTime = json['add_time'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sex'] = this.sex;
    data['head_img'] = this.headImg;
    data['username'] = this.username;
    data['wx_json'] = this.wxJson;
    data['phone_num'] = this.phoneNum;
    data['update_time'] = this.updateTime;
    data['add_time'] = this.addTime;
    data['user'] = this.user;
    return data;
  }
}
