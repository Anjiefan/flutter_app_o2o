//TODO 这里是展示一个订单的用例，后续需要根据实际业务进行修改
import 'package:yunzhixiao_customer_client/models/shop.dart';
import 'package:yunzhixiao_customer_client/models/userinfo.dart';
import 'commodity.dart';


class Order {
  int id;
  UserInfo userInfo;
  Shop shop;
  List<GetOrderCommodityOrderRelate> getOrderCommodityOrderRelate;
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
        this.shopUser,
        this.pickUpType,
        this.pickUpTimeChoice,
        this.packingMoney
        });

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