class UserInfo {
  int id;
  String sex;
  String headImg;
  String username;
  String wxJson;
  String phoneNum;
  String updateTime;
  String addTime;
  int user;

  UserInfo(
      {this.id,
        this.sex,
        this.headImg,
        this.username,
        this.wxJson,
        this.phoneNum,
        this.updateTime,
        this.addTime,
        this.user});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sex = json['sex'];
    headImg = json['head_img'];
    username = json['username'];
    wxJson = json['wx_json'];
    phoneNum = json['phone_num'];
    updateTime = json['update_time'];
    addTime = json['add_time'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sex'] = this.sex;
    data['head_img'] = this.headImg;
    data['username'] = this.username;
    data['wx_json'] = this.wxJson;
    data['phone_num'] = this.phoneNum;
    data['update_time'] = this.updateTime;
    data['add_time'] = this.addTime;
    data['user'] = this.user;
    return data;
  }
}