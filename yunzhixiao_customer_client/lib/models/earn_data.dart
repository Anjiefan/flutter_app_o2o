class EarnDataInfoDetail {
  int id;
  String spendUser;
  String date;
  String incident;
  double campusCode;

  EarnDataInfoDetail({this.id, this.spendUser, this.date, this.incident, this.campusCode});

  EarnDataInfoDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    spendUser = json['spend_user'];
    date = json['date'];
    incident = json['incident'];
    campusCode = json['campus_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['spend_user'] = this.spendUser;
    data['date'] = this.date;
    data['incident'] = this.incident;
    data['campus_code'] = this.campusCode;
    return data;
  }
}