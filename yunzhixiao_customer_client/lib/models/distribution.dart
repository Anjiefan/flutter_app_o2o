class Distribution {
  int todayDistributionNum;
  int yesterdayDistributionNum;
  int monthDistributionNum;
  double todayEarnNum;
  double yesterdayEarnNum;
  double monthEarnNum;
  int yesterdayIndirectDistributionNum;
  int todayIndirectDistributionNum;
  int monthIndirectDistributionNum;
  int promotionNum;
  double promotionSum;
  int allDistributionNum;
  Distribution(
      {this.todayDistributionNum,
        this.yesterdayDistributionNum,
        this.monthDistributionNum,
        this.todayEarnNum,
        this.yesterdayEarnNum,
        this.monthEarnNum,
        this.yesterdayIndirectDistributionNum,
        this.todayIndirectDistributionNum,
        this.monthIndirectDistributionNum,
        this.promotionNum,
        this.promotionSum});

  Distribution.fromJson(Map<String, dynamic> json) {
    todayDistributionNum = json['today_distribution_num'];
    yesterdayDistributionNum = json['yesterday_distribution_num'];
    monthDistributionNum = json['month_distribution_num'];
    todayEarnNum = json['today_earn_num'];
    yesterdayEarnNum = json['yesterday_earn_num'];
    monthEarnNum = json['month_earn_num'];
    yesterdayIndirectDistributionNum =
    json['yesterday_indirect_distribution_num'];
    todayIndirectDistributionNum = json['today_indirect_distribution_num'];
    monthIndirectDistributionNum = json['month_indirect_distribution_num'];
    promotionNum = json['promotion_num'];
    promotionSum = json['promotion_sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['today_distribution_num'] = this.todayDistributionNum;
    data['yesterday_distribution_num'] = this.yesterdayDistributionNum;
    data['month_distribution_num'] = this.monthDistributionNum;
    data['today_earn_num'] = this.todayEarnNum;
    data['yesterday_earn_num'] = this.yesterdayEarnNum;
    data['month_earn_num'] = this.monthEarnNum;
    data['yesterday_indirect_distribution_num'] =
        this.yesterdayIndirectDistributionNum;
    data['today_indirect_distribution_num'] = this.todayIndirectDistributionNum;
    data['month_indirect_distribution_num'] = this.monthIndirectDistributionNum;
    data['promotion_num'] = this.promotionNum;
    data['promotion_sum'] = this.promotionSum;
    return data;
  }
}