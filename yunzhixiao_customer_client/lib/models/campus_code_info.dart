class CampusCodeInfoList {
  CampusCodeInfo data;

  CampusCodeInfoList({this.data});

  CampusCodeInfoList.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new CampusCodeInfo.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class CampusCodeInfo {
  double outcome;
  double income;
  List<CampusCodeInfoDetail> data;

  CampusCodeInfo({this.outcome, this.income, this.data});

  CampusCodeInfo.fromJson(Map<String, dynamic> json) {
    outcome = json['outcome'];
    income = json['income'];
    if (json['data'] != null) {
      data = new List<CampusCodeInfoDetail>();
      json['data'].forEach((v) {
        data.add(new CampusCodeInfoDetail.fromJson(v));
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

class CampusCodeInfoDetail {
  int id;
  String campusCode;
  String incident;
  String operate;
  String date;
  int user;

  CampusCodeInfoDetail(
      {this.id,
        this.campusCode,
        this.incident,
        this.operate,
        this.date,
        this.user});

  CampusCodeInfoDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    campusCode = json['campus_code'];
    incident = json['incident'];
    operate = json['operate'];
    date = json['date'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['campus_code'] = this.campusCode;
    data['incident'] = this.incident;
    data['operate'] = this.operate;
    data['date'] = this.date;
    data['user'] = this.user;
    return data;
  }
}
