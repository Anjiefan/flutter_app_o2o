class DailyInviteList {
  List<DailyInvite> data;

  DailyInviteList({this.data});

  DailyInviteList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<DailyInvite>();
      json['data'].forEach((v) {
        data.add(new DailyInvite.fromJson(v));
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

class DailyInvite {
  int id;
  int invitesNumAll;
  int invitesNum;
  int invitesConsumeThis;
  int invitesConsumeOthers;
  double invitesDivideThis;
  double invitesDivideOthers;
  double invitesSellThis;
  double invitesSellSum;
  String date;
  String updateDate;
  int shop;
  int user;

  DailyInvite(
      {this.id,
        this.invitesNumAll,
        this.invitesNum,
        this.invitesConsumeThis,
        this.invitesConsumeOthers,
        this.invitesDivideThis,
        this.invitesDivideOthers,
        this.invitesSellThis,
        this.invitesSellSum,
        this.date,
        this.updateDate,
        this.shop,
        this.user});

  DailyInvite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invitesNumAll = json['invites_num_all'];
    invitesNum = json['invites_num'];
    invitesConsumeThis = json['invites_consume_this'];
    invitesConsumeOthers = json['invites_consume_others'];
    invitesDivideThis = json['invites_divide_this'];
    invitesDivideOthers = json['invites_divide_others'];
    invitesSellThis = json['invites_sell_this'];
    invitesSellSum = json['invites_sell_sum'];
    date = json['date'];
    updateDate = json['update_date'];
    shop = json['shop'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invites_num_all'] = this.invitesNumAll;
    data['invites_num'] = this.invitesNum;
    data['invites_consume_this'] = this.invitesConsumeThis;
    data['invites_consume_others'] = this.invitesConsumeOthers;
    data['invites_divide_this'] = this.invitesDivideThis;
    data['invites_divide_others'] = this.invitesDivideOthers;
    data['invites_sell_this'] = this.invitesSellThis;
    data['invites_sell_sum'] = this.invitesSellSum;
    data['date'] = this.date;
    data['update_date'] = this.updateDate;
    data['shop'] = this.shop;
    data['user'] = this.user;
    return data;
  }
}
