import 'package:yunzhixiao_business_client/models/commodity.dart';

class DailyCommodityList {
  List<DailyCommodity> data;

  DailyCommodityList({this.data});

  DailyCommodityList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<DailyCommodity>();
      json['data'].forEach((v) {
        data.add(new DailyCommodity.fromJson(v));
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

class DailyCommodity {
  int id;
  Commodity commodity;
  String goodRate;
  String badRate;
  int sales;
  double salesOfAmount;
  int goodNum;
  int badNum;
  String date;
  String updateDate;
  int user;
  int shop;

  DailyCommodity(
      {this.id,
        this.commodity,
        this.goodRate,
        this.badRate,
        this.sales,
        this.salesOfAmount,
        this.goodNum,
        this.badNum,
        this.date,
        this.updateDate,
        this.user,
        this.shop});

  DailyCommodity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    commodity = json['commodity'] != null
        ? new Commodity.fromJson(json['commodity'])
        : null;
    goodRate = json['good_rate'];
    badRate = json['bad_rate'];
    sales = json['sales'];
    salesOfAmount = json['sales_of_amount'];
    goodNum = json['good_num'];
    badNum = json['bad_num'];
    date = json['date'];
    updateDate = json['update_date'];
    user = json['user'];
    shop = json['shop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.commodity != null) {
      data['commodity'] = this.commodity.toJson();
    }
    data['good_rate'] = this.goodRate;
    data['bad_rate'] = this.badRate;
    data['sales'] = this.sales;
    data['sales_of_amount'] = this.salesOfAmount;
    data['good_num'] = this.goodNum;
    data['bad_num'] = this.badNum;
    data['date'] = this.date;
    data['update_date'] = this.updateDate;
    data['user'] = this.user;
    data['shop'] = this.shop;
    return data;
  }
}