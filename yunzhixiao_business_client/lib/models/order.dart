//TODO 这里是展示一个订单的用例，后续需要根据实际业务进行修改
import 'package:yunzhixiao_business_client/models/shop.dart';
import 'package:yunzhixiao_business_client/models/userinfo.dart';
import 'commodity.dart';

class RewardList {
  String rewardId;
  String rewardTitle;
  String applyPrice;
  String totalVotes;
  String surplusVotes;
  String device;
  String avatar;
  String catName;
  String catCode;
  String catId;
  String tagsName;
  String tagsId;
  String redpacketsId;
  String surplusNumber;
  String isTop;
  String topEndTime;
  String views;
  String topUpdate;
  String deposit;
  String vipId;
  String act;
  String rewardUri;
  String rewardUrl;
  String catUri;
  String catUrl;
  String phone;
  String nickname;
  String catType;

  RewardList(
      {this.rewardId,
      this.rewardTitle,
      this.applyPrice,
      this.totalVotes,
      this.surplusVotes,
      this.device,
      this.avatar,
      this.catName,
      this.catCode,
      this.catId,
      this.tagsName,
      this.tagsId,
      this.redpacketsId,
      this.surplusNumber,
      this.isTop,
      this.topEndTime,
      this.views,
      this.topUpdate,
      this.deposit,
      this.vipId,
      this.act,
      this.rewardUri,
      this.rewardUrl,
      this.catUri,
      this.catUrl,
      this.phone,
      this.nickname,
      this.catType});

  RewardList.fromJson(Map<String, dynamic> json) {
    rewardId = json['reward_id'];
    rewardTitle = json['reward_title'];
    applyPrice = json['apply_price'];
    totalVotes = json['total_votes'];
    surplusVotes = json['surplus_votes'];
    device = json['device'];
    avatar = json['avatar'];
    catName = json['cat_name'];
    catCode = json['cat_code'];
    catId = json['cat_id'];
    tagsName = json['tags_name'];
    tagsId = json['tags_id'];
    redpacketsId = json['redpackets_id'];
    surplusNumber = json['surplus_number'];
    isTop = json['is_top'];
    topEndTime = json['top_end_time'];
    views = json['views'];
    topUpdate = json['top_update'];
    deposit = json['deposit'];
    vipId = json['vip_id'];
    act = json['act'];
    rewardUri = json['reward_uri'];
    rewardUrl = json['reward_url'];
    catUri = json['cat_uri'];
    catUrl = json['cat_url'];
    phone = json['phone'];
    nickname = json['nickname'];
    catType = json['cat_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reward_id'] = this.rewardId;
    data['reward_title'] = this.rewardTitle;
    data['apply_price'] = this.applyPrice;
    data['total_votes'] = this.totalVotes;
    data['surplus_votes'] = this.surplusVotes;
    data['device'] = this.device;
    data['avatar'] = this.avatar;
    data['cat_name'] = this.catName;
    data['cat_code'] = this.catCode;
    data['cat_id'] = this.catId;
    data['tags_name'] = this.tagsName;
    data['tags_id'] = this.tagsId;
    data['redpackets_id'] = this.redpacketsId;
    data['surplus_number'] = this.surplusNumber;
    data['is_top'] = this.isTop;
    data['top_end_time'] = this.topEndTime;
    data['views'] = this.views;
    data['top_update'] = this.topUpdate;
    data['deposit'] = this.deposit;
    data['vip_id'] = this.vipId;
    data['act'] = this.act;
    data['reward_uri'] = this.rewardUri;
    data['reward_url'] = this.rewardUrl;
    data['cat_uri'] = this.catUri;
    data['cat_url'] = this.catUrl;
    data['phone'] = this.phone;
    data['nickname'] = this.nickname;
    data['cat_type'] = this.catType;
    return data;
  }
}

class AfterSell {
  String detailReason;
  String reason;

  AfterSell({this.detailReason, this.reason});

  AfterSell.fromJson(Map<String, dynamic> json) {
    detailReason = json['detail_reason'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['detail_reason'] = this.detailReason;
    data['reason'] = this.reason;
    return data;
  }
}

class Order {
  int id;
  UserInfo userInfo;
  Shop shop;
  List<GetOrderCommodityOrderRelate> getOrderCommodityOrderRelate;
  AfterSell afterSell;
  String payType;
  String status;
  String commodityStatus;
  String updateDate;
  String date;
  String payStatus;
  int num;
  int commodityStatusId;
  String orderNum;
  String phoneNum;
  String shopName;
  bool ifPublic;
  String shopAddress;
  String shopPhoneNum;
  int serviceNumber;
  bool isSlow;
  bool isCancel;
  bool isAfterSell;
  bool isComment;
  double serviceMoney;
  double discountMoney;
  double sumMoney;
  int shopNum;
  String remark;
  int user;
  int shopUser;
  int pickUpType;
  int pickUpTimeChoice;
  String pickUpTime;
  double packingMoney;

  Order(
      {this.id,
      this.userInfo,
      this.shop,
      this.getOrderCommodityOrderRelate,
      this.payType,
      this.status,
      this.commodityStatus,
      this.updateDate,
      this.date,
      this.payStatus,
      this.num,
      this.commodityStatusId,
      this.orderNum,
      this.phoneNum,
      this.shopName,
      this.ifPublic,
      this.shopAddress,
      this.shopPhoneNum,
      this.serviceNumber,
      this.isSlow,
      this.isCancel,
      this.isAfterSell,
      this.isComment,
      this.serviceMoney,
      this.discountMoney,
      this.sumMoney,
      this.shopNum,
      this.remark,
      this.user,
      this.afterSell,
      this.shopUser,
      this.pickUpType,
      this.pickUpTimeChoice,
      this.packingMoney,
      this.pickUpTime});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userInfo = json['user_info'] != null
        ? new UserInfo.fromJson(json['user_info'])
        : null;
    shop = json['shop'] != null ? new Shop.fromJson(json['shop']) : null;
    if (json['get_order_commodity_order_relate'] != null) {
      getOrderCommodityOrderRelate = new List<GetOrderCommodityOrderRelate>();
      json['get_order_commodity_order_relate'].forEach((v) {
        getOrderCommodityOrderRelate
            .add(new GetOrderCommodityOrderRelate.fromJson(v));
      });
    }
    afterSell = json['after_sell'] != null
        ? new AfterSell.fromJson(json['after_sell'])
        : null;
    payType = json['pay_type'];
    status = json['status'];
    commodityStatus = json['commodity_status'];
    updateDate = json['update_date'];
    date = json['date'];
    payStatus = json['pay_status'];
    num = json['num'];
    commodityStatusId = json['commodity_status_id'];
    orderNum = json['order_num'];
    phoneNum = json['phone_num'];
    shopName = json['shop_name'];
    ifPublic = json['if_public'];
    shopAddress = json['shop_address'];
    shopPhoneNum = json['shop_phone_num'];
    serviceNumber = json['service_number'];
    isSlow = json['is_slow'];
    isCancel = json['is_cancel'];
    isAfterSell = json['is_after_sell'];
    isComment = json['is_comment'];
    serviceMoney = json['service_money'];
    discountMoney = json['discount_money'];
    sumMoney = json['sum_money'];
    shopNum = json['shop_num'];
    remark = json['remark'];
    user = json['user'];
    shopUser = json['shop_user'];
    pickUpType = json['pick_up_type'];
    pickUpTimeChoice = json['pick_up_time_choice'];
    packingMoney = json['packing_money'];
    pickUpTime = json['pick_up_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.userInfo != null) {
      data['user_info'] = this.userInfo.toJson();
    }
    if (this.shop != null) {
      data['shop'] = this.shop.toJson();
    }
    if (this.getOrderCommodityOrderRelate != null) {
      data['get_order_commodity_order_relate'] =
          this.getOrderCommodityOrderRelate.map((v) => v.toJson()).toList();
    }
    data['pay_type'] = this.payType;
    data['status'] = this.status;
    data['commodity_status'] = this.commodityStatus;
    data['update_date'] = this.updateDate;
    data['date'] = this.date;
    data['pay_status'] = this.payStatus;
    data['num'] = this.num;
    data['commodity_status_id'] = this.commodityStatusId;
    data['order_num'] = this.orderNum;
    data['phone_num'] = this.phoneNum;
    data['shop_name'] = this.shopName;
    data['if_public'] = this.ifPublic;
    data['shop_address'] = this.shopAddress;
    data['shop_phone_num'] = this.shopPhoneNum;
    data['service_number'] = this.serviceNumber;
    data['is_slow'] = this.isSlow;
    data['is_cancel'] = this.isCancel;
    data['is_after_sell'] = this.isAfterSell;
    data['is_comment'] = this.isComment;
    data['service_money'] = this.serviceMoney;
    data['discount_money'] = this.discountMoney;
    data['sum_money'] = this.sumMoney;
    data['shop_num'] = this.shopNum;
    data['remark'] = this.remark;
    data['user'] = this.user;
    data['shop_user'] = this.shopUser;
    data['pick_up_type'] = this.pickUpType;
    data['pick_up_time_choice'] = this.pickUpTimeChoice;
    data['packing_money'] = this.packingMoney;
    data['pick_up_time'] = this.pickUpTime;
    return data;
  }
}

class GetOrderCommodityOrderRelate {
  int id;
  Commodity commodity;
  int quantity;
  String date;
  String updateDate;
  int order;

  GetOrderCommodityOrderRelate(
      {this.id,
      this.commodity,
      this.quantity,
      this.date,
      this.updateDate,
      this.order});

  GetOrderCommodityOrderRelate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    commodity = json['commodity'] != null
        ? new Commodity.fromJson(json['commodity'])
        : null;
    quantity = json['quantity'];
    date = json['date'];
    updateDate = json['update_date'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.commodity != null) {
      data['commodity'] = this.commodity.toJson();
    }
    data['quantity'] = this.quantity;
    data['date'] = this.date;
    data['update_date'] = this.updateDate;
    data['order'] = this.order;
    return data;
  }
}
