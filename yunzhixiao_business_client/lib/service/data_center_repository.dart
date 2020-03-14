import 'package:yunzhixiao_business_client/commons/nets/http.dart';
import 'package:yunzhixiao_business_client/models/daily_commodity.dart';
import 'package:yunzhixiao_business_client/models/daily_earn.dart';
import 'package:yunzhixiao_business_client/models/daily_invite.dart';
import 'package:yunzhixiao_business_client/models/daily_promotion_effect.dart';
import 'package:yunzhixiao_business_client/models/daliy_service.dart';
import 'package:yunzhixiao_business_client/models/shop_comment.dart';

class DataCenterRepository{
  static Future fetchDailyEarn({int year, int month,int day}) async {
    var response = await http.netFetch('daily_earn/',params:{
      'year': year,
      'month': month,
      'day':day,
    },method: 'get');
    return DailyEarnList.fromJson(response.data).data;
  }

  static Future fetchDailyInvite({int year, int month,int day}) async {
    var response = await http.netFetch('daily_invite/',params:{
      'year': year,
      'month': month,
      'day':day,
    },method: 'get');
    return DailyInviteList.fromJson(response.data).data;
  }

  static Future fetchDailyService({int year, int month,int day}) async {
    var response = await http.netFetch('daily_service/',params:{
      'year': year,
      'month': month,
      'day':day,
    },method: 'get');
    return DailyServiceList.fromJson(response.data).data;
  }

  static Future fetchDailyPromotionEffect({int year, int month,int day}) async {
    var response = await http.netFetch('daily_promotion_effect/',params:{
      'year': year,
      'month': month,
      'day':day,

    },method: 'get');
    return DailyPromotionEffectList.fromJson(response.data).data;
  }

  static Future fetchDailyCommodity({int year, int month,int day,String ordering}) async {
    var response = await http.netFetch('daily_commodity/',params:{
      'year': year,
      'month': month,
      'day':day,
      'ordering':ordering
    },method: 'get');
    return DailyCommodityList.fromJson(response.data).data;
  }
}