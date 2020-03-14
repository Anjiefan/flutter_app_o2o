class DailyPromotionEffectList {
  List<DailyPromotionEffect> data;

  DailyPromotionEffectList({this.data});

  DailyPromotionEffectList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<DailyPromotionEffect>();
      json['data'].forEach((v) {
        data.add(new DailyPromotionEffect.fromJson(v));
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

class DailyPromotionEffect {
  int id;
  int moneyOffOrderNum;
  double moneyOffPerCustomerTransaction;
  double moneyOffSalesOfAmount;
  int lockedRedPacketOrderNum;
  int lockedRedPacketLockedUser;
  int lockedRedPacketSalesOfAmount;
  int shareRedPacketOckedUser;
  double shareRedPacketSalesOfAmount;
  int lockedDiscountOrderNum;
  double lockedDiscountSalesOfAmount;
  String date;
  String updateDate;
  int shop;
  int user;

  DailyPromotionEffect(
      {this.id,
        this.moneyOffOrderNum,
        this.moneyOffPerCustomerTransaction,
        this.moneyOffSalesOfAmount,
        this.lockedRedPacketOrderNum,
        this.lockedRedPacketLockedUser,
        this.lockedRedPacketSalesOfAmount,
        this.shareRedPacketOckedUser,
        this.shareRedPacketSalesOfAmount,
        this.lockedDiscountOrderNum,
        this.lockedDiscountSalesOfAmount,
        this.date,
        this.updateDate,
        this.shop,
        this.user});

  DailyPromotionEffect.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    moneyOffOrderNum = json['money_off_order_num'];
    moneyOffPerCustomerTransaction = json['money_off_per_customer_transaction'];
    moneyOffSalesOfAmount = json['money_off_sales_of_amount'];
    lockedRedPacketOrderNum = json['locked_red_packet_order_num'];
    lockedRedPacketLockedUser = json['locked_red_packet_locked_user'];
    lockedRedPacketSalesOfAmount = json['locked_red_packet_sales_of_amount'];
    shareRedPacketOckedUser = json['share_red_packet_ocked_user'];
    shareRedPacketSalesOfAmount = json['share_red_packet_sales_of_amount'];
    lockedDiscountOrderNum = json['locked_discount_order_num'];
    lockedDiscountSalesOfAmount = json['locked_discount_sales_of_amount'];
    date = json['date'];
    updateDate = json['update_date'];
    shop = json['shop'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['money_off_order_num'] = this.moneyOffOrderNum;
    data['money_off_per_customer_transaction'] =
        this.moneyOffPerCustomerTransaction;
    data['money_off_sales_of_amount'] = this.moneyOffSalesOfAmount;
    data['locked_red_packet_order_num'] = this.lockedRedPacketOrderNum;
    data['locked_red_packet_locked_user'] = this.lockedRedPacketLockedUser;
    data['locked_red_packet_sales_of_amount'] =
        this.lockedRedPacketSalesOfAmount;
    data['share_red_packet_ocked_user'] = this.shareRedPacketOckedUser;
    data['share_red_packet_sales_of_amount'] = this.shareRedPacketSalesOfAmount;
    data['locked_discount_order_num'] = this.lockedDiscountOrderNum;
    data['locked_discount_sales_of_amount'] = this.lockedDiscountSalesOfAmount;
    data['date'] = this.date;
    data['update_date'] = this.updateDate;
    data['shop'] = this.shop;
    data['user'] = this.user;
    return data;
  }
}
