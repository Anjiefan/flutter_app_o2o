class MoneyOffPromotionList {
  List<MoneyOffPromotion> data;

  MoneyOffPromotionList({this.data});

  MoneyOffPromotionList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<MoneyOffPromotion>();
      json['data'].forEach((v) {
        data.add(new MoneyOffPromotion.fromJson(v));
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

class MoneyOffPromotion {
  int id;
  String status;
  List<PriceBetween> priceBetween;
  String date;
  String updateDate;
  int shop;
  int user;

  MoneyOffPromotion(
      {this.id,
        this.status,
        this.priceBetween,
        this.date,
        this.updateDate,
        this.shop,
        this.user});

  MoneyOffPromotion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    if (json['price_between'] != null) {
      priceBetween = new List<PriceBetween>();
      json['price_between'].forEach((v) {
        priceBetween.add(new PriceBetween.fromJson(v));
      });
    }
    date = json['date'];
    updateDate = json['update_date'];
    shop = json['shop'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    if (this.priceBetween != null) {
      data['price_between'] = this.priceBetween.map((v) => v.toJson()).toList();
    }
    data['date'] = this.date;
    data['update_date'] = this.updateDate;
    data['shop'] = this.shop;
    data['user'] = this.user;
    return data;
  }
}

class PriceBetween {
  int discount;
  int condition;

  PriceBetween({this.discount, this.condition});

  PriceBetween.fromJson(Map<String, dynamic> json) {
    discount = json['discount'];
    condition = json['condition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['discount'] = this.discount;
    data['condition'] = this.condition;
    return data;
  }
}
