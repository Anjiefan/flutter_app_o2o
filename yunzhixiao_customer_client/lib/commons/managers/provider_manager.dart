import 'package:provider/provider.dart';
import 'package:yunzhixiao_customer_client/view_model/home/shop_model.dart';
import 'package:yunzhixiao_customer_client/view_model/home/shop_share_model.dart';
import 'package:yunzhixiao_customer_client/view_model/settings_model.dart';
import 'package:yunzhixiao_customer_client/view_model/system/search_model.dart';
import 'package:yunzhixiao_customer_client/view_model/system/system_static_model.dart';
import 'package:yunzhixiao_customer_client/view_model/theme_model.dart';
import 'package:yunzhixiao_customer_client/view_model/user/red_packet_model.dart';
import 'package:yunzhixiao_customer_client/view_model/user/user_model.dart';
import 'package:yunzhixiao_customer_client/view_model/order_model.dart';
List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...uiConsumableProviders
];

/// 独立的model
List<SingleChildCloneableWidget> independentServices = [
  ChangeNotifierProvider<ThemeModel>(
    create: (context) => ThemeModel(),
  ),

  ChangeNotifierProvider<UserModel>(
    create: (context) => UserModel(),
  ),

  ChangeNotifierProvider<SettingsModel>(
    create: (context) => SettingsModel(),
  ),
  ChangeNotifierProvider<SystemStaticModel>(
    create: (context) => SystemStaticModel(),
  ),
  //需要用户登录权限的api
  ChangeNotifierProvider<ShopShareListModel>(
    create: (context) => ShopShareListModel(),
  ),
  ChangeNotifierProvider<ShopListModel>(
    create: (context) => ShopListModel(),
  ),
  ChangeNotifierProvider<AllOrderListModel>(
    create: (context) => AllOrderListModel(),
  ),
  ChangeNotifierProvider<WaitingPayListModel>(
    create: (context) => WaitingPayListModel(),
  ),
  ChangeNotifierProvider<WaitingReciveListModel>(
    create: (context) => WaitingReciveListModel(),
  ),
  ChangeNotifierProvider<AfterSellListModel>(
    create: (context) => AfterSellListModel(),
  ),
  ChangeNotifierProvider<SearchModel>(
    create: (context) => SearchModel(),
  ),
];



/// 需要依赖的model
///
/// UserModel依赖globalFavouriteStateModel
//List<SingleChildCloneableWidget> dependentServices = [
//  ChangeNotifierProxyProvider<GlobalFavouriteStateModel, UserModel>(
//    create: null,
//    update: (context, globalFavouriteStateModel, userModel) =>
//    userModel ??
//        UserModel(globalFavouriteStateModel: globalFavouriteStateModel),
//  )
//];

List<SingleChildCloneableWidget> uiConsumableProviders = [
//  StreamProvider<User>(
//    builder: (context) => Provider.of<AuthenticationService>(context, listen: false).user,
//  )
];
