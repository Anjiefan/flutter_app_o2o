class CommodityList {
  List<Commodity> data;

  CommodityList({this.data});

  CommodityList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Commodity>();
      json['data'].forEach((v) {
        data.add(new Commodity.fromJson(v));
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

class Commodity {
  int id;
  String name;
  String img;
  double price;
  int status;
  int sellNum;
  int sellNumMonth;
  int commentNum;
  int likeCommentNum;
  int dislikeCommentNum;
  double goodCommentProbability;
  double badCommentProbability;
  double discountPrice;
  bool isHot;
  bool isTop;
  String info;
  String date;
  String updateDate;
  int shop;
  int user;
  int type;

  Commodity(
      {this.id,
        this.name,
        this.img,
        this.price,
        this.status,
        this.sellNum,
        this.sellNumMonth,
        this.commentNum,
        this.likeCommentNum,
        this.dislikeCommentNum,
        this.goodCommentProbability,
        this.badCommentProbability,
        this.discountPrice,
        this.isHot,
        this.isTop,
        this.info,
        this.date,
        this.updateDate,
        this.shop,
        this.user,
        this.type});

  Commodity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    price = json['price'];
    status = json['status'];
    sellNum = json['sell_num'];
    sellNumMonth = json['sell_num_month'];
    commentNum = json['comment_num'];
    likeCommentNum = json['like_comment_num'];
    dislikeCommentNum = json['dislike_comment_num'];
    goodCommentProbability = json['good_comment_probability'];
    badCommentProbability = json['bad_comment_probability'];
    discountPrice = json['discount_price'];
    isHot = json['is_hot'];
    isTop = json['is_top'];
    info = json['info'];
    date = json['date'];
    updateDate = json['update_date'];
    shop = json['shop'];
    user = json['user'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['img'] = this.img;
    data['price'] = this.price;
    data['status'] = this.status;
    data['sell_num'] = this.sellNum;
    data['sell_num_month'] = this.sellNumMonth;
    data['comment_num'] = this.commentNum;
    data['like_comment_num'] = this.likeCommentNum;
    data['dislike_comment_num'] = this.dislikeCommentNum;
    data['good_comment_probability'] = this.goodCommentProbability;
    data['bad_comment_probability'] = this.badCommentProbability;
    data['discount_price'] = this.discountPrice;
    data['is_hot'] = this.isHot;
    data['is_top'] = this.isTop;
    data['info'] = this.info;
    data['date'] = this.date;
    data['update_date'] = this.updateDate;
    data['shop'] = this.shop;
    data['user'] = this.user;
    data['type'] = this.type;
    return data;
  }
}