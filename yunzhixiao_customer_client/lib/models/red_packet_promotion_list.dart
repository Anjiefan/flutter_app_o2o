class RedPacketPromotionList {
  List<RedPacketPromotion> data;

  RedPacketPromotionList({this.data});

  RedPacketPromotionList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<RedPacketPromotion>();
      json['data'].forEach((v) {
        data.add(new RedPacketPromotion.fromJson(v));
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

class RedPacketPromotion {
  int id;
  String status;
  double discountPrice;
  String date;
  String updateDate;
  int shop;
  int user;

  RedPacketPromotion(
      {this.id,
        this.status,
        this.discountPrice,
        this.date,
        this.updateDate,
        this.shop,
        this.user});

  RedPacketPromotion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    discountPrice = json['discount_price'];
    date = json['date'];
    updateDate = json['update_date'];
    shop = json['shop'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['discount_price'] = this.discountPrice;
    data['date'] = this.date;
    data['update_date'] = this.updateDate;
    data['shop'] = this.shop;
    data['user'] = this.user;
    return data;
  }
}
