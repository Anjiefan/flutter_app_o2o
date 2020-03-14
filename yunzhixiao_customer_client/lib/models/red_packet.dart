import 'package:yunzhixiao_customer_client/models/shop.dart';

class RedPacket {
  int id;
  Shop shop;
  int promotion;
  String promotionModel;
  String promotionDescribe;
  double promotionDiscountPrice;
  double promotionDiscount;
  bool isUsed;
  String dueDate;
  String date;
  String updateDate;
  int shopUser;

  RedPacket(
      {this.id,
        this.shop,
        this.promotion,
        this.promotionModel,
        this.promotionDescribe,
        this.promotionDiscountPrice,
        this.promotionDiscount,
        this.isUsed,
        this.dueDate,
        this.date,
        this.updateDate,
        this.shopUser});

  RedPacket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shop = json['shop'] != null ? new Shop.fromJson(json['shop']) : null;
    promotion = json['promotion'];
    promotionModel = json['promotion_model'];
    promotionDescribe = json['promotion_describe'];
    promotionDiscountPrice = json['promotion_discount_price'];
    promotionDiscount = json['promotion_discount'];
    isUsed = json['is_used'];
    dueDate = json['due_date'];
    date = json['date'];
    updateDate = json['update_date'];
    shopUser = json['shop_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.shop != null) {
      data['shop'] = this.shop.toJson();
    }
    data['promotion'] = this.promotion;
    data['promotion_model'] = this.promotionModel;
    data['promotion_describe'] = this.promotionDescribe;
    data['promotion_discount_price'] = this.promotionDiscountPrice;
    data['promotion_discount'] = this.promotionDiscount;
    data['is_used'] = this.isUsed;
    data['due_date'] = this.dueDate;
    data['date'] = this.date;
    data['update_date'] = this.updateDate;
    data['shop_user'] = this.shopUser;
    return data;
  }
}
