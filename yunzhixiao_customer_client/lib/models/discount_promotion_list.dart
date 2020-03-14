class DiscountPromotionList {
  List<DiscountPromotion> data;

  DiscountPromotionList({this.data});

  DiscountPromotionList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<DiscountPromotion>();
      json['data'].forEach((v) {
        data.add(new DiscountPromotion.fromJson(v));
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

class DiscountPromotion {
  int id;
  String status;
  double discount;
  String date;
  String updateDate;
  int shop;
  int user;

  DiscountPromotion(
      {this.id,
        this.status,
        this.discount,
        this.date,
        this.updateDate,
        this.shop,
        this.user});

  DiscountPromotion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    discount = json['discount'];
    date = json['date'];
    updateDate = json['update_date'];
    shop = json['shop'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['discount'] = this.discount;
    data['date'] = this.date;
    data['update_date'] = this.updateDate;
    data['shop'] = this.shop;
    data['user'] = this.user;
    return data;
  }
}
