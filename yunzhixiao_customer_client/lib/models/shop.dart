class ShopList {
  List<Shop> data;

  ShopList({this.data});

  ShopList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Shop>();
      json['data'].forEach((v) {
        data.add(new Shop.fromJson(v));
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

class Shop {
  int id;
  bool isOpen;
  Type type;
  School school;
  List<String> promotionList;
  String shareLink;
  String name;
  String phoneNum;
  int sellNumMounth;
  String inviteCustomerPromotionHint;
  List<PromotionDict> promotionDict;
  int sellNum;
  double level;
  double longitude;
  double latitude;
  String address;
  String desc;
  String img;
  String logo;
  int likeCommentNum;
  int dislikeCommentNum;
  int imgCommentNum;
  String show;
  double sortLevel;
  bool isToPublic;
  int commentNumSum;
  int startTime;
  int endTime;
  int startTimeMinute;
  int endTimeMinute;
  int status;
  bool handIsOpen;
  String date;
  String updateDate;
  String platform;
  String deviceToken;
  bool startSmsAlert;
  int user;

  Shop(
      {this.id,
        this.isOpen,
        this.type,
        this.school,
        this.promotionList,
        this.shareLink,
        this.name,
        this.phoneNum,
        this.sellNumMounth,
        this.sellNum,
        this.level,
        this.longitude,
        this.latitude,
        this.address,
        this.desc,
        this.img,
        this.logo,
        this.likeCommentNum,
        this.dislikeCommentNum,
        this.imgCommentNum,
        this.show,
        this.sortLevel,
        this.isToPublic,
        this.commentNumSum,
        this.startTime,
        this.endTime,
        this.startTimeMinute,
        this.endTimeMinute,
        this.status,
        this.handIsOpen,
        this.date,
        this.updateDate,
        this.platform,
        this.deviceToken,
        this.startSmsAlert,
        this.inviteCustomerPromotionHint,
        this.promotionDict,
        this.user});

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isOpen = json['is_open'];
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
    school =
    json['school'] != null ? new School.fromJson(json['school']) : null;
    promotionList = json['promotion_list'] != null ? json['promotion_list'].cast<String>():[];


    shareLink = json['share_link'];
    name = json['name'];
    phoneNum = json['phone_num'];
    sellNumMounth = json['sell_num_mounth'];
    sellNum = json['sell_num'];
    level = json['level'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    address = json['address'];
    desc = json['desc'];
    img = json['img'];
    logo = json['logo'];
    likeCommentNum = json['like_comment_num'];
    dislikeCommentNum = json['dislike_comment_num'];
    imgCommentNum = json['img_comment_num'];
    show = json['show'];
    sortLevel = json['sort_level'];
    isToPublic = json['is_to_public'];
    commentNumSum = json['comment_num_sum'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    startTimeMinute = json['start_time_minute'];
    endTimeMinute = json['end_time_minute'];
    status = json['status'];
    handIsOpen = json['hand_is_open'];
    date = json['date'];
    updateDate = json['update_date'];
    platform = json['platform'];
    deviceToken = json['device_token'];
    startSmsAlert = json['start_sms_alert'];
    user = json['user'];
    inviteCustomerPromotionHint = json['invite_customer_promotion_hint'];
    if (json['promotion_dict'] != null) {
      promotionDict = new List<PromotionDict>();
      json['promotion_dict'].forEach((v) {
        promotionDict.add(new PromotionDict.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_open'] = this.isOpen;
    if (this.type != null) {
      data['type'] = this.type.toJson();
    }
    if (this.school != null) {
      data['school'] = this.school.toJson();
    }
    data['invite_customer_promotion_hint']=this.inviteCustomerPromotionHint;
    if (this.promotionDict != null) {
      data['promotion_dict'] =
          this.promotionDict.map((v) => v.toJson()).toList();
    }
    data['promotion_list'] = this.promotionList;
    data['share_link'] = this.shareLink;
    data['name'] = this.name;
    data['phone_num'] = this.phoneNum;
    data['sell_num_mounth'] = this.sellNumMounth;
    data['sell_num'] = this.sellNum;
    data['level'] = this.level;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['address'] = this.address;
    data['desc'] = this.desc;
    data['img'] = this.img;
    data['logo'] = this.logo;
    data['like_comment_num'] = this.likeCommentNum;
    data['dislike_comment_num'] = this.dislikeCommentNum;
    data['img_comment_num'] = this.imgCommentNum;
    data['show'] = this.show;
    data['sort_level'] = this.sortLevel;
    data['is_to_public'] = this.isToPublic;
    data['comment_num_sum'] = this.commentNumSum;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['start_time_minute'] = this.startTimeMinute;
    data['end_time_minute'] = this.endTimeMinute;
    data['status'] = this.status;
    data['hand_is_open'] = this.handIsOpen;
    data['date'] = this.date;
    data['update_date'] = this.updateDate;
    data['platform'] = this.platform;
    data['device_token'] = this.deviceToken;
    data['start_sms_alert'] = this.startSmsAlert;
    data['user'] = this.user;
    return data;
  }
}

class PromotionDict {
  String key;
  String value;

  PromotionDict({this.key, this.value});

  PromotionDict.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}

class Type {
  int id;
  int categoryType;
  int status;
  String name;
  String img;
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
    data['disc'] = this.disc;
    data['date'] = this.date;
    data['update_date'] = this.updateDate;
    data['father_type'] = this.fatherType;
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
