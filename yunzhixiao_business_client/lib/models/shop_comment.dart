import 'package:yunzhixiao_business_client/models/shop.dart';
import 'package:yunzhixiao_business_client/models/userinfo.dart';

import 'commodity.dart';

class ShopComment {
  List<ShopCommentItem> data;

  ShopComment({this.data});

  ShopComment.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<ShopCommentItem>();
      json['data'].forEach((v) {
        data.add(new ShopCommentItem.fromJson(v));
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

class ShopCommentItem {
  int id;
  UserInfo userInfo;
  Shop shop;
  List<Commodity> commodity;
  String img;
  String content;
  int isGood;
  bool isImgComment;
  int orderId;
  String orderModel;
  String date;
  int user;
  int shopUser;

  ShopCommentItem(
      {this.id,
        this.userInfo,
        this.shop,
        this.commodity,
        this.img,
        this.content,
        this.isGood,
        this.isImgComment,
        this.orderId,
        this.orderModel,
        this.date,
        this.user,
        this.shopUser});

  ShopCommentItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userInfo = json['user_info'] != null
        ? new UserInfo.fromJson(json['user_info'])
        : null;
    shop = json['shop'] != null ? new Shop.fromJson(json['shop']) : null;
    if (json['commodity'] != null) {
      commodity = new List<Commodity>();
      json['commodity'].forEach((v) {
        commodity.add(new Commodity.fromJson(v));
      });
    }
    img = json['img'];
    content = json['content'];
    isGood = json['is_good'];
    isImgComment = json['is_img_comment'];
    orderId = json['order_id'];
    orderModel = json['order_model'];
    date = json['date'];
    user = json['user'];
    shopUser = json['shop_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.userInfo != null) {
      data['user_info'] = this.userInfo.toJson();
    }
    if (this.shop != null) {
      data['shop'] = this.shop.toJson();
    }
    if (this.commodity != null) {
      data['commodity'] = this.commodity.map((v) => v.toJson()).toList();
    }
    data['img'] = this.img;
    data['content'] = this.content;
    data['is_good'] = this.isGood;
    data['is_img_comment'] = this.isImgComment;
    data['order_id'] = this.orderId;
    data['order_model'] = this.orderModel;
    data['date'] = this.date;
    data['user'] = this.user;
    data['shop_user'] = this.shopUser;
    return data;
  }
}


