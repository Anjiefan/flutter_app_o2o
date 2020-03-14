
import 'package:yunzhixiao_business_client/models/school.dart';
import 'package:yunzhixiao_business_client/models/shop_type.dart';

class Shop {
  int id;
  bool isOpen;
  ShopType type;
  School school;
  String name;
  String phoneNum;
  int sellNumMounth;
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
  int startTimeMinute;
  int endTime;
  int endTimeMinute;
  int status;
  bool handIsOpen;
  String date;
  String updateDate;
  int user;
  double packingCharge;

  Shop(
      {this.id,
        this.isOpen,
        this.type,
        this.school,
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
        this.user,
        this.packingCharge});

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isOpen = json['is_open'];
    type = json['type'] != null ? new ShopType.fromJson(json['type']) : null;
    school =
    json['school'] != null ? new School.fromJson(json['school']) : null;
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
    user = json['user'];
    packingCharge = json['packing_charge'];
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
    data['user'] = this.user;
    data['packing_charge'] = this.packingCharge;
    return data;
  }
}