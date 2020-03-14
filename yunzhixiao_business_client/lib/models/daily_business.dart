import 'package:yunzhixiao_business_client/models/daily_earn.dart';

import 'daily_invite.dart';

class DailyBusinessInfo{

  final List<DailyEarn> dailyEarnList;
  final List<DailyInvite> dailyInviteList;

  DailyBusinessInfo(this.dailyEarnList, this.dailyInviteList);

}