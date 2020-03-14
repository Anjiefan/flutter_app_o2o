class ShopInviteData {
  int yesterdayNum;
  int todayNum;
  int mounthNum;
  double mounthInvitesDivideThis;
  double invitesDivideThisSum;
  double totalBusiness;
  int validOrdersNum;
  ShopInviteData(
      {this.yesterdayNum,
        this.todayNum,
        this.mounthNum,
        this.mounthInvitesDivideThis,
        this.invitesDivideThisSum,
        this.totalBusiness,
        this.validOrdersNum,
      });

  ShopInviteData.fromJson(Map<String, dynamic> json) {
    yesterdayNum = json['yesterday_num'];
    todayNum = json['today_num'];
    mounthNum = json['mounth_num'];
    mounthInvitesDivideThis = json['mounth_invites_divide_this'];
    invitesDivideThisSum = json['invites_divide_this_sum'];
    validOrdersNum = json['valid_orders_num'];
    totalBusiness = json['total_business'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['yesterday_num'] = this.yesterdayNum;
    data['today_num'] = this.todayNum;
    data['mounth_num'] = this.mounthNum;
    data['mounth_invites_divide_this'] = this.mounthInvitesDivideThis;
    data['invites_divide_this_sum'] = this.invitesDivideThisSum;
    data['valid_orders_num'] = this.validOrdersNum;
    data['total_business'] = this.totalBusiness;
    return data;
  }
}
