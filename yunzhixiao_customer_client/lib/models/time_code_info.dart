class TimeCodeInfoList {
  TimeCodeInfo data;

  TimeCodeInfoList({this.data});

  TimeCodeInfoList.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new TimeCodeInfo.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class TimeCodeInfo {
  double outcome;
  double income;
  List<TimeCodeInfoDetail> data;

  TimeCodeInfo({this.outcome, this.income, this.data});

  TimeCodeInfo.fromJson(Map<String, dynamic> json) {
    outcome = json['outcome'];
    income = json['income'];
    if (json['data'] != null) {
      data = new List<TimeCodeInfoDetail>();
      json['data'].forEach((v) {
        data.add(new TimeCodeInfoDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['outcome'] = this.outcome;
    data['income'] = this.income;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimeCodeInfoDetail {
  int id;
  String timeCode;
  String incident;
  String operate;
  String date;
  int user;

  TimeCodeInfoDetail(
      {this.id,
        this.timeCode,
        this.incident,
        this.operate,
        this.date,
        this.user});

  TimeCodeInfoDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timeCode = json['time_code'];
    incident = json['incident'];
    operate = json['operate'];
    date = json['date'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['time_code'] = this.timeCode;
    data['incident'] = this.incident;
    data['operate'] = this.operate;
    data['date'] = this.date;
    data['user'] = this.user;
    return data;
  }
}
