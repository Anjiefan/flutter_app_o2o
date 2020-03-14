class DailyEarnList {
  List<DailyEarn> data;

  DailyEarnList({this.data});

  DailyEarnList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<DailyEarn>();
      json['data'].forEach((v) {
        data.add(new DailyEarn.fromJson(v));
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

class DailyEarn {
  int id;
  int validOrdersNum;
  int invalidOrdersNum;
  int relateOrdersNum;
  double invitesDivideNum;
  double totalLoss;
  double totalSell;
  double totalBusiness;
  String date;
  String updateDate;
  int shop;
  int user;

  DailyEarn(
      {this.id,
        this.validOrdersNum,
        this.invalidOrdersNum,
        this.relateOrdersNum,
        this.invitesDivideNum,
        this.totalLoss,
        this.totalSell,
        this.totalBusiness,
        this.date,
        this.updateDate,
        this.shop,
        this.user});

  DailyEarn.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    validOrdersNum = json['valid_orders_num'];
    invalidOrdersNum = json['invalid_orders_num'];
    relateOrdersNum = json['relate_orders_num'];
    invitesDivideNum = json['invites_divide_num'];
    totalLoss = json['total_loss'];
    totalSell = json['total_sell'];
    totalBusiness = json['total_business'];
    date = json['date'];
    updateDate = json['update_date'];
    shop = json['shop'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['valid_orders_num'] = this.validOrdersNum;
    data['invalid_orders_num'] = this.invalidOrdersNum;
    data['relate_orders_num'] = this.relateOrdersNum;
    data['invites_divide'] = this.invitesDivideNum;
    data['total_loss'] = this.totalLoss;
    data['total_sell'] = this.totalSell;
    data['total_business'] = this.totalBusiness;
    data['date'] = this.date;
    data['update_date'] = this.updateDate;
    data['shop'] = this.shop;
    data['user'] = this.user;
    return data;
  }
}
