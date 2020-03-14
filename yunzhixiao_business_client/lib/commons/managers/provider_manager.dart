import 'package:provider/provider.dart';
import 'package:yunzhixiao_business_client/view_model/order/order_model.dart';
import 'package:yunzhixiao_business_client/view_model/push_model.dart';
import 'package:yunzhixiao_business_client/view_model/settings_model.dart';
import 'package:yunzhixiao_business_client/view_model/system_static_model.dart';
import 'package:yunzhixiao_business_client/view_model/theme_model.dart';
import 'package:yunzhixiao_business_client/view_model/user/user_model.dart';

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
  ChangeNotifierProvider<PushModel>(
    create: (context) => PushModel(),
  ),
  ChangeNotifierProvider<DoingOrderModel>(
    create: (context) => DoingOrderModel(),
  ),
  ChangeNotifierProvider<ArchiveOrderModel>(
    create: (context) => ArchiveOrderModel(),
  ),
  ChangeNotifierProvider<LazyOrderModel>(
    create: (context) => LazyOrderModel(),
  ),
  ChangeNotifierProvider<CancelOrderModel>(
    create: (context) => CancelOrderModel(),
  ),

  ChangeNotifierProvider<NewOperateOrder>(
    create: (context) => NewOperateOrder(),
  ),
  ChangeNotifierProvider<WaitOperateOrder>(
    create: (context) => WaitOperateOrder(),
  ),
  ChangeNotifierProvider<TakeOperateOrder>(
    create: (context) => TakeOperateOrder(),
  ),
  ChangeNotifierProvider<UrgeOperateOrder>(
    create: (context) => UrgeOperateOrder(),
  ),
  ChangeNotifierProvider<CancelOperateOrder>(
    create: (context) => CancelOperateOrder(),
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
