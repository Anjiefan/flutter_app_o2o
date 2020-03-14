class VerificationInfo {
  int id;
  School school;
  Type type;
  String logo;
  String name;
  String phoneNum;
  String address;
  int status;
  String date;
  String updateDate;
  int longitude;
  int latitude;
  String username;
  String messagePhoneNum;
  String businessName;
  String businessNum;
  String businessImg;
  String businessManName;
  String businessAddress;
  String businessStartTime;
  String businessEndTime;
  String licenceName;
  String licenceImg;
  String licenceAddress;
  String licenceUsername;
  String licenceNum;
  String licenceEndTime;
  String idcardBack;
  String idcardBehind;
  String idcardName;
  String idcardNum;
  int user;

  VerificationInfo(
      {this.id,
      this.school,
      this.type,
      this.logo,
      this.name,
      this.phoneNum,
      this.address,
      this.status,
      this.date,
      this.updateDate,
      this.longitude,
      this.latitude,
      this.username,
      this.messagePhoneNum,
      this.businessName,
      this.businessNum,
      this.businessImg,
      this.businessManName,
      this.businessAddress,
      this.businessStartTime,
      this.businessEndTime,
      this.licenceName,
      this.licenceImg,
      this.licenceAddress,
      this.licenceUsername,
      this.licenceNum,
      this.licenceEndTime,
      this.idcardBack,
      this.idcardBehind,
      this.idcardName,
      this.idcardNum,
      this.user});

  VerificationInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    school =
        json['school'] != null ? new School.fromJson(json['school']) : null;
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
    logo = json['logo'];
    name = json['name'];
    phoneNum = json['phone_num'];
    address = json['address'];
    status = json['status'];
    date = json['date'];
    updateDate = json['update_date'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    username = json['username'];
    messagePhoneNum = json['message_phone_num'];
    businessName = json['business_name'];
    businessNum = json['business_num'];
    businessImg = json['business_img'];
    businessManName = json['business_man_name'];
    businessAddress = json['business_address'];
    businessStartTime = json['business_start_time'];
    businessEndTime = json['business_end_time'];
    licenceName = json['licence_name'];
    licenceImg = json['licence_img'];
    licenceAddress = json['licence_address'];
    licenceUsername = json['licence_username'];
    licenceNum = json['licence_num'];
    licenceEndTime = json['licence_end_time'];
    idcardBack = json['idcard_back'];
    idcardBehind = json['idcard_behind'];
    idcardName = json['idcard_name'];
    idcardNum = json['idcard_num'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.school != null) {
      data['school'] = this.school.toJson();
    }
    if (this.type != null) {
      data['type'] = this.type.toJson();
    }
    data['logo'] = this.logo;
    data['name'] = this.name;
    data['phone_num'] = this.phoneNum;
    data['address'] = this.address;
    data['status'] = this.status;
    data['date'] = this.date;
    data['update_date'] = this.updateDate;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['username'] = this.username;
    data['message_phone_num'] = this.messagePhoneNum;
    data['business_name'] = this.businessName;
    data['business_num'] = this.businessNum;
    data['business_img'] = this.businessImg;
    data['business_man_name'] = this.businessManName;
    data['business_address'] = this.businessAddress;
    data['business_start_time'] = this.businessStartTime;
    data['business_end_time'] = this.businessEndTime;
    data['licence_name'] = this.licenceName;
    data['licence_img'] = this.licenceImg;
    data['licence_address'] = this.licenceAddress;
    data['licence_username'] = this.licenceUsername;
    data['licence_num'] = this.licenceNum;
    data['licence_end_time'] = this.licenceEndTime;
    data['idcard_back'] = this.idcardBack;
    data['idcard_behind'] = this.idcardBehind;
    data['idcard_name'] = this.idcardName;
    data['idcard_num'] = this.idcardNum;
    data['user'] = this.user;
    return data;
  }
}

class School {
  int id;
  String name;
  double longitude;
  double latitude;
  String province;
  String city;
  String district;
  String date;
  String updateDate;

  School(
      {this.id,
      this.name,
      this.longitude,
      this.latitude,
      this.province,
      this.city,
      this.district,
      this.date,
      this.updateDate});

  School.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    province = json['province'];
    city = json['city'];
    district = json['district'];
    date = json['date'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['province'] = this.province;
    data['city'] = this.city;
    data['district'] = this.district;
    data['date'] = this.date;
    data['update_date'] = this.updateDate;
    return data;
  }
}

class Type {
  int id;
  int categoryType;
  int status;
  String name;
  String img;
  double ordering;
  String disc;
  String date;
  String updateDate;
  int fatherType;

  Type(
      {this.id,
      this.categoryType,
      this.status,
      this.name,
      this.img,
      this.ordering,
      this.disc,
      this.date,
      this.updateDate,
      this.fatherType});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryType = json['category_type'];
    status = json['status'];
    name = json['name'];
    img = json['img'];
    ordering = json['ordering'];
    disc = json['disc'];
    date = json['date'];
    updateDate = json['update_date'];
    fatherType = json['father_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_type'] = this.categoryType;
    data['status'] = this.status;
    data['name'] = this.name;
    data['img'] = this.img;
    data['ordering'] = this.ordering;
    data['disc'] = this.disc;
    data['date'] = this.date;
    data['update_date'] = this.updateDate;
    data['father_type'] = this.fatherType;
    return data;
  }
}
