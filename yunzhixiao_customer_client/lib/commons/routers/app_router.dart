import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yunzhixiao_customer_client/commons/routers/router.dart';
import 'package:yunzhixiao_customer_client/commons/routers/page_router_anim.dart';
import 'package:yunzhixiao_customer_client/models/order.dart';
import 'package:yunzhixiao_customer_client/models/shop.dart';
import 'package:yunzhixiao_customer_client/uis/pages/commons/qrcode_view.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/home_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/search_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/shop/detail/home_shop_detail_home_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/shop/detail/home_shop_detail_single_commodity_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/shop/home_shop_cart_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/shop/home_shop_list_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/home/shop/home_shop_payment_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/order/order_cancel_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/order/order_comment_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/order/order_detail_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/order/order_pay_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/order/order_pick_up_list_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/order/order_qr_code_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/splash_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/tab/tab_nav_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/user/app_info_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/user/distribution/user_distribution_detail_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/user/login/login_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/user/login/login_register_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/user/message/user_message_home_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/user/red_packet/user_red_packet_home_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/user/user_change_password_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/user/distribution/user_distribution_home_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/user/wallet/user_wallet_campus_code_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/user/wallet/user_wallet_rmb_detail_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/user/wallet/user_wallet_rmb_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/user/wallet/user_wallet_time_code_detail_page.dart';
import 'package:yunzhixiao_customer_client/uis/pages/webview.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/flutter_datetime_picker/src/i18n_model.dart';
import 'package:yunzhixiao_customer_client/view_model/home/detail/shop_commodity_detail_model.dart';
import 'package:yunzhixiao_customer_client/view_model/home/shop_model.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash:
        return NoAnimRouteBuilder(SplashPage());
      case RouteName.tab:
        int where = settings.arguments;
        return CupertinoPageRoute(
          builder: (_) => TabNavigator(
            where: where,
          ),
        );
      case RouteName.login:
        return CupertinoPageRoute(builder: (_) => LoginPage());
      case RouteName.register:
        return CupertinoPageRoute(builder: (_) => LoginRegisterPage());
      case RouteName.changePassword:
        return CupertinoPageRoute(builder: (_) => UserChangePasswordPage());
      case RouteName.home:
        return CupertinoPageRoute(builder: (_) => HomePage());
      case RouteName.homeShopList:
        var shopListParam = settings.arguments as ShopListParam;
        return CupertinoPageRoute(
            builder: (_) => HomeShopListPage(
                  shopListParam: shopListParam,
                ));
      case RouteName.homeShopDetail:
        var shopId = settings.arguments as int;
        return CupertinoPageRoute(
            builder: (_) => HomeShopDetailPage(
                  shopId: shopId,
                ));
      case RouteName.homeShopDetailSingleCommodity:
        var param = settings.arguments as SingleCommodityParam;
        return MaterialPageRoute(
            builder: (_) => HomeShopDetailSingleCommodityPage(param: param));
      case RouteName.homeShopCart:
        return CupertinoPageRoute(builder: (_) => HomeShopCartPage());
      case RouteName.orderPay:
        List arguments = settings.arguments;
        return CupertinoPageRoute(
            builder: (_) => OrderPaymentPage(order: arguments[0]));
      case RouteName.homeShopPayment:
        var param = settings.arguments as ShopPaymentParam;
        return CupertinoPageRoute(
            builder: (_) => HomeShopPaymentPage(param: param));
      case RouteName.orderDetail:
        var param = settings.arguments as int;
        return CupertinoPageRoute(
            builder: (_) => OrderDetailPage(orderId: param));
      case RouteName.orderQRCode:
        List arguments = settings.arguments;
        return CupertinoPageRoute(
            builder: (_) => OrderQRCodePage(
                  order: arguments[0],
                ));
      case RouteName.userAppInfo:
        return CupertinoPageRoute(builder: (_) => AppInfoPage());
      case RouteName.userRedPacket:
        int shopId = settings.arguments as int;
        return CupertinoPageRoute(
            builder: (_) => UserRedPacketPage(shopId: shopId));
      case RouteName.userDistribution:
        return CupertinoPageRoute(builder: (_) => UserDistributionPage());
      case RouteName.userDistributionDetail:
        return CupertinoPageRoute(builder: (_) => UserDistributionDetailPage());
      case RouteName.userMessage:
        return CupertinoPageRoute(builder: (_) => UserMessageHomePage());
      case RouteName.userWalletRMB:
        return CupertinoPageRoute(builder: (_) => UserWalletRMBPage());
      case RouteName.userWalletRMBDetail:
        return CupertinoPageRoute(builder: (_) => UserWalletRMBDetailPage());
      case RouteName.userWalletCampusCode:
        return CupertinoPageRoute(builder: (_) => UserWalletCampusCodePage());
      case RouteName.userWalletCampusCodeDetail:
        return CupertinoPageRoute(
            builder: (_) => UserWalletTimeCodeDetailPage());
      case RouteName.shopSearch:
        return CupertinoPageRoute(builder: (_) => SearchPage());
      case RouteName.orderCancel:
        int orderId = settings.arguments;
        return CupertinoPageRoute(
            builder: (_) => OrderCancelPage(
                  orderId: orderId,
                ));
      case RouteName.orderPickUp:
        return CupertinoPageRoute(builder: (_) => OrderPickUpListPage());
      case RouteName.qrcodeView:
        return CupertinoPageRoute(builder: (_) => QRScanView());
      case RouteName.orderComment:
        List arguments = settings.arguments;
        return CupertinoPageRoute(
            builder: (_) => OrderCommentPage(
                  order: arguments[0],
                  orderListModel: arguments[1],
                ));
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
