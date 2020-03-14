class DailyServiceList {
  List<DailyService> data;

  DailyServiceList({this.data});

  DailyServiceList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<DailyService>();
      json['data'].forEach((v) {
        data.add(new DailyService.fromJson(v));
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

class DailyService {
  int id;
  String rejectRate;
  String hurryRate;
  String cancelRate;
  String badRate;
  int rejectNum;
  int hurryNum;
  int cancelNum;
  int totalOrders;
  int badNum;
  int totalComments;
  String date;
  String updateDate;
  int shop;
  int user;

  DailyService(
      {this.id,
        this.rejectRate,
        this.hurryRate,
        this.cancelRate,
        this.badRate,
        this.rejectNum,
        this.hurryNum,
        this.cancelNum,
        this.totalOrders,
        this.badNum,
        this.totalComments,
        this.date,
        this.updateDate,
        this.shop,
        this.user});

  DailyService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rejectRate = json['reject_rate'];
    hurryRate = json['hurry_rate'];
    cancelRate = json['cancel_rate'];
    badRate = json['bad_rate'];
    rejectNum = json['reject_num'];
    hurryNum = json['hurry_num'];
    cancelNum = json['cancel_num'];
    totalOrders = json['total_orders'];
    badNum = json['bad_num'];
    totalComments = json['total_comments'];
    date = json['date'];
    updateDate = json['update_date'];
    shop = json['shop'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reject_rate'] = this.rejectRate;
    data['hurry_rate'] = this.hurryRate;
    data['cancel_rate'] = this.cancelRate;
    data['bad_rate'] = this.badRate;
    data['reject_num'] = this.rejectNum;
    data['hurry_num'] = this.hurryNum;
    data['cancel_num'] = this.cancelNum;
    data['total_orders'] = this.totalOrders;
    data['bad_num'] = this.badNum;
    data['total_comments'] = this.totalComments;
    data['date'] = this.date;
    data['update_date'] = this.updateDate;
    data['shop'] = this.shop;
    data['user'] = this.user;
    return data;
  }
}
