import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yunzhixiao_business_client/commons/routers/router.dart';
import 'package:yunzhixiao_business_client/commons/routers/page_router_anim.dart';
import 'package:yunzhixiao_business_client/models/order.dart';
import 'package:yunzhixiao_business_client/uis/pages/.trash/activity_detail_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/order_process/message_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/order_process/order_process_search_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/order_search/order_search_action_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/activity/activity_invite_red_packet.dart';
import 'package:yunzhixiao_business_client/uis/pages/.trash/activity_list_item.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/activity/activity_lock_customer_discount.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/activity/activity_lock_customer_red_packet.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/activity/activity_money_off_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/comment/comment_home_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/commodity_manage/add_category_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/commodity_manage/add_commodity_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/commodity_manage/category_edit_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/commodity_manage/category_manage_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/commodity_manage/change_commodity_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/commodity_manage/choose_category_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/commodity_manage/commodity_manage_home_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/commodity_manage/commodity_sell_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/commodity_manage/commodity_sort_manage_home_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/commodity_manage/comodity_multi_manage_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/data_center/data_center_home_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/.trash/activity_home_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/lock_customer/lock_customer_detail.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/market_data_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/wallet/wallet_detail_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/wallet/wallet_home_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/shop_manage/wallet/wallet_qa_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/splash_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/tab/tab_nav_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/user/app_info_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/user/login/login_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/setting_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/user/login/login_register_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/user/login/login_register_verify.dart';
import 'package:yunzhixiao_business_client/uis/pages/user/notification_settings/notification_settings_home_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/user/order_settings/order_settings_home_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/user/shop_settings/shop_settings_basic_info_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/user/shop_settings/shop_settings_basic_info_qrcode_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/user/shop_settings/shop_settings_basic_info_school.dart';
import 'package:yunzhixiao_business_client/uis/pages/user/shop_settings/shop_settings_home_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/user/shop_settings/shop_settings_operate_info_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/user/shop_settings/shop_type_choose_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/user/shop_settings/shop_type_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/user/user_change_password_page.dart';
import 'package:yunzhixiao_business_client/uis/pages/webview.dart';
import 'package:yunzhixiao_business_client/view_model/shop_manage/commodity/commodity_type_model.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash:
        return NoAnimRouteBuilder(SplashPage());
      case RouteName.tab:
        return NoAnimRouteBuilder(TabNavigator());
      case RouteName.login:
        return CupertinoPageRoute(builder: (_) => LoginPage());
      case RouteName.register:
        return CupertinoPageRoute(builder: (_) => LoginRegisterPage());
      case RouteName.registerVerify:
        return CupertinoPageRoute(builder: (_) => LoginRegisterVerifyPage(
        ));
      case RouteName.setting:
        return CupertinoPageRoute(builder: (_) => SettingPage());
      case RouteName.shopManageCommodity:
        return CupertinoPageRoute(builder: (_) => SettingPage());
      case RouteName.shopManageWallet:
        return CupertinoPageRoute(builder: (_) => WalletHomePage());
      case RouteName.shopManageWalletQA:
        return CupertinoPageRoute(builder: (_) => WalletQAPage());
      case RouteName.shopManageWalletDetail:
        return CupertinoPageRoute(builder: (_) => WalletDetailPage());
      case RouteName.shopManageComment:
        return CupertinoPageRoute(builder: (_) => CommentHomePage());
      case RouteName.shopManageData:
        return CupertinoPageRoute(builder: (_) => SettingPage());
      case RouteName.shopManageLockCustomerDetail:
        return CupertinoPageRoute(builder: (_) => LockCustomerDetailPage());
      case RouteName.shopManageActivity:
        return CupertinoPageRoute(builder: (_) => ShopManageActivityPage());
      case RouteName.shopManageActivityMoneyOff:
        return CupertinoPageRoute(builder: (_) => ActivityMoneyOffPage());
      case RouteName.shopManageActivityLockCustomerRedPacket:
        return CupertinoPageRoute(
            builder: (_) => ActivityLockCustomerRedPacketPage());
      case RouteName.shopManageActivityInviteRedPacket:
        return CupertinoPageRoute(
            builder: (_) => ActivityInviteRedPacketPage());
      case RouteName.shopManageActivityLockCustomerDiscount:
        return CupertinoPageRoute(
            builder: (_) => ActivityLockCustomerDiscountPage());
      case RouteName.appInfo:
        return CupertinoPageRoute(builder: (_) => AppInfoPage());
      case RouteName.shopManageActivityDetail:
        var activityItem = settings.arguments as RewardList;
        return CupertinoPageRoute(
            builder: (_) => ActivityDetailPage(activityItem: activityItem));
      case RouteName.userShopSettingsHome:
        return CupertinoPageRoute(builder: (_) => ShopSettingsHomePage());
      case RouteName.userShopSettingsBasicInfo:
        return CupertinoPageRoute(builder: (_) => ShopSettingsBasicInfoPage());
      case RouteName.userShopSettingsBasicInfoQRCode:
        return CupertinoPageRoute(
            builder: (_) => ShopSettingsBasicInfoQRCodePage());
      case RouteName.userShopSettingsOperateInfo:
        return CupertinoPageRoute(
            builder: (_) => ShopSettingsOperateInfoPage());
      case RouteName.userOrderSettingsHome:
        return CupertinoPageRoute(builder: (_) => OrderSettingsHomePage());
      case RouteName.userNotificationSettingsHome:
        return CupertinoPageRoute(
            builder: (_) => NotificationSettingsHomePage());
      case RouteName.userChangePassword:
        return CupertinoPageRoute(builder: (_) => UserChangePasswordPage());
      case RouteName.shopManageDataHome:
        return CupertinoPageRoute(builder: (_) => DataHomePage());
      case RouteName.shopManageMarketData:
        return CupertinoPageRoute(builder: (_) => MarketDataPage());
      case RouteName.shopManageCommodityManagePage:
        return CupertinoPageRoute(builder: (_) => CommodityManagePage());
      case RouteName.shopCategoryPage:
        var commodityTypeModel = settings.arguments as CommodityTypeModel;
        return CupertinoPageRoute(
            builder: (_) => CategoryPage(model: commodityTypeModel));
      case RouteName.shopAddCategoryPage:
        return CupertinoPageRoute(builder: (_) => AddCategoryPage());
      case RouteName.shopManageSortCommodityPage:
        return CupertinoPageRoute(builder: (_) => CommoditySortManagePage());
      case RouteName.shopAddCommodityPage:
        return CupertinoPageRoute(builder: (_) => AddCommodityPage());
      case RouteName.shopCategoryEditPage:
        var commodityTypeId = settings.arguments as int;
        return CupertinoPageRoute(
            builder: (_) => CategoryEditPage(commodityTypeId: commodityTypeId));
      case RouteName.shopChooseCategoryPage:
        return CupertinoPageRoute(builder: (_) => ChooseCategoryPage());
      case RouteName.shopchangeCommodityPage:
        var commodityId = settings.arguments as int;
        return CupertinoPageRoute(
            builder: (_) => ChangeCommodityPage(commodityId: commodityId));
      case RouteName.shopManageCommoditySellPage:
        return CupertinoPageRoute(builder: (_) => ShopDataPage());
      case RouteName.shopManageCommodityMultiManagePage:
        return CupertinoPageRoute(builder: (_) => CommodityMultiManagePage());
      case RouteName.userShopTypeChooseSettings:
        return CupertinoPageRoute(builder: (_) => ShopTypePage());
      case RouteName.orderSearchAction:
        return CupertinoPageRoute(builder: (_) => OrderSearchActionPage());
      case RouteName.orderProcessSearch:
        return CupertinoPageRoute(builder: (_) => OrderProcessSearchPage());
      case RouteName.systemMessage:
        return CupertinoPageRoute(builder: (_) => MessagePage());
      case RouteName.webView:
        List arguments = settings.arguments;
        return CupertinoPageRoute(
            builder: (_) => WebViewPage(
              url: arguments[0],
              title: arguments[1],
            ));
      default:
        return CupertinoPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
