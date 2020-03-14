import 'package:yunzhixiao_customer_client/models/shop.dart';

import 'commodity.dart';

class CartInfoList {
  List<CartInfo> data;

  CartInfoList({this.data});

  CartInfoList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<CartInfo>();
      json['data'].forEach((v) {
        data.add(new CartInfo.fromJson(v));
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

class CartInfo {
  int id;
  List<CartCommodityCartRelate> cartCommodityCartRelate;
  String totalPrice;
  String totalPriceWithoutDiscount;
  Shop shop;
  String date;
  String updateDate;
  int user;
//  List<int> commodity;

  CartInfo(
      {this.id,
        this.cartCommodityCartRelate,
        this.totalPrice,
        this.totalPriceWithoutDiscount,
        this.shop,
        this.date,
        this.updateDate,
        this.user,
//        this.commodity
      });

  CartInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['cart_commodity_cart_relate'] != null) {
      cartCommodityCartRelate = new List<CartCommodityCartRelate>();
      json['cart_commodity_cart_relate'].forEach((v) {
        cartCommodityCartRelate.add(new CartCommodityCartRelate.fromJson(v));
      });
    }
    totalPrice = json['total_price'];
    totalPriceWithoutDiscount = json['total_price_without_discount'];
    shop = json['shop'] != null ? new Shop.fromJson(json['shop']) : null;
    date = json['date'];
    updateDate = json['update_date'];
    user = json['user'];
//    if (json['commodity'] != null) {
//      commodity = new List<Null>();
//      json['commodity'].forEach((v) {
//        commodity.add(v);
//      });
//    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.cartCommodityCartRelate != null) {
      data['cart_commodity_cart_relate'] =
          this.cartCommodityCartRelate.map((v) => v.toJson()).toList();
    }
    data['total_price'] = this.totalPrice;
    data['total_price_without_discount'] = this.totalPriceWithoutDiscount;
    if (this.shop != null) {
      data['shop'] = this.shop.toJson();
    }
    data['date'] = this.date;
    data['update_date'] = this.updateDate;
    data['user'] = this.user;
//    if (this.commodity != null) {
//      data['commodity'] = this.commodity.map((v) => v).toList();
//    }
    return data;
  }
}



class CartCommodityCartRelate {
  Commodity commodity;
  int quantity;

  CartCommodityCartRelate({this.commodity, this.quantity});

  CartCommodityCartRelate.fromJson(Map<String, dynamic> json) {
    commodity = json['commodity'] != null
        ? new Commodity.fromJson(json['commodity'])
        : null;
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.commodity != null) {
      data['commodity'] = this.commodity.toJson();
    }
    data['quantity'] = this.quantity;
    return data;
  }
}

class CartNum {
  int cartNum;

  CartNum({this.cartNum});

  CartNum.fromJson(Map<String, dynamic> json) {
    cartNum = json['cart_num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_num'] = this.cartNum;
    return data;
  }
}

