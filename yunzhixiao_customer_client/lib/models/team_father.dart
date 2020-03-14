import 'package:yunzhixiao_customer_client/models/user_data.dart';

class TeamFather {
  List<UserData> userData;
  int firstNum;
  int secondNum;

  TeamFather({this.userData, this.firstNum, this.secondNum});

  TeamFather.fromJson(Map<String, dynamic> json) {
    if (json['user_data'] != null) {
      userData = new List<UserData>();
      json['user_data'].forEach((v) {
        userData.add(new UserData.fromJson(v));
      });
    }
    firstNum = json['first_num'];
    secondNum = json['second_num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userData != null) {
      data['user_data'] = this.userData.map((v) => v.toJson()).toList();
    }
    data['first_num'] = this.firstNum;
    data['second_num'] = this.secondNum;
    return data;
  }
}
