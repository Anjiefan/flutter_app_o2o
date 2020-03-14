class Withdrawaccount {
  int id;
  String alyPayAccount;
  String weixinPayAccount;
  String date;
  String updateDate;
  int user;

  Withdrawaccount(
      {this.id,
        this.alyPayAccount,
        this.weixinPayAccount,
        this.date,
        this.updateDate,
        this.user});

  Withdrawaccount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    alyPayAccount = json['aly_pay_account'];
    weixinPayAccount = json['weixin_pay_account'];
    date = json['date'];
    updateDate = json['update_date'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['aly_pay_account'] = this.alyPayAccount;
    data['weixin_pay_account'] = this.weixinPayAccount;
    data['date'] = this.date;
    data['update_date'] = this.updateDate;
    data['user'] = this.user;
    return data;
  }
}
