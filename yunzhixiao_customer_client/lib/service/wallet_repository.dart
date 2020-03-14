import 'package:yunzhixiao_customer_client/commons/nets/http.dart';
import 'package:yunzhixiao_customer_client/models/campus_code_info.dart';
import 'package:yunzhixiao_customer_client/models/earn_data_list.dart';
import 'package:yunzhixiao_customer_client/models/time_code_info.dart';
import 'package:yunzhixiao_customer_client/models/user.dart';
import 'package:yunzhixiao_customer_client/view_model/user/distribution/earn_code_info_model.dart';

class WalletRepository {
  static Future withdraw(code) async {
    var response = await http.netFetch('withdraw/', method: 'post', params: {
      'code': code
    });
    return response.data;
  }

  static Future updateWithdrawAccount({String alipayAccount, String wxPayAccount, User user}) async {
    var response = await http.netFetch('withdraw_account/1/', method: 'put', params: {
      "aly_pay_account": alipayAccount == null ? user.withdrawaccount.alyPayAccount: alipayAccount,
      "weixin_pay_account": wxPayAccount == null ? user.withdrawaccount.weixinPayAccount: wxPayAccount
    });
    return response.data;
  }

  static Future fetchCampusCodeInfoDetail({int page, int year, int month}) async {
    var response = await http.netFetch('campuscodeinfos/',
        params: {
          "page": page == null ? 1 : page,
          "year": year == null ? '' : year,
          "month": month == null ? '' : month
        },
        method: 'get');
    return CampusCodeInfoList.fromJson(response.data).data.data;
  }

  static Future fetchCampusCodeInfo({int year, int month}) async {
    var response = await http.netFetch('campuscodeinfos/',
        params: {
          "page": 1,
          "year": year == null ? '' : year,
          "month": month == null ? '' : month
        },
        method: 'get');
    return CampusCodeInfoList.fromJson(response.data).data;
  }

  static Future fetchTimeCodeInfoDetail({int page, int year, int month}) async {
    var response = await http.netFetch('timecodeinfos/',
        params: {
          "page": page == null ? 1 : page,
          "year": year == null ? '' : year,
          "month": month == null ? '' : month
        },
        method: 'get');
    return TimeCodeInfoList.fromJson(response.data).data.data;
  }

  static Future fetchTimeCodeInfo({int year, int month}) async {
    var response = await http.netFetch('timecodeinfos/',
        params: {
          "page": 1,
          "year": year == null ? '' : year,
          "month": month == null ? '' : month
        },
        method: 'get');
    return TimeCodeInfoList.fromJson(response.data).data;
  }

  static Future fetchEarnCodeInfoDetail({int page, int year, int month,int day}) async {
    var response = await http.netFetch('earncodeinfos/',
        params: {
          "page": page == null ? 1 : page,
          "year": year == null ? '' : year,
          "month": month == null ? '' : month,
          "day": day == null ? '' : day
        },
        method: 'get');
    return EarnDataList.fromJson(response.data).data.data;
  }
  static Future fetchEarnCodeInfo({int page, int year, int month,int day}) async {
    var response = await http.netFetch('earncodeinfos/',
        params: {
          "page": page == null ? 1 : page,
          "year": year == null ? '' : year,
          "month": month == null ? '' : month,
          "day": day == null ? '' : day
        },
        method: 'get');
    return EarnDataList.fromJson(response.data).data;
  }
}
