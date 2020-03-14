//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'package:pull_to_refresh/pull_to_refresh.dart';
//import 'package:random_color/random_color.dart';
//import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
//import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
//import 'package:yunzhixiao_business_client/uis/widgets/circle_point_widget.dart';
//import 'package:yunzhixiao_business_client/uis/widgets/my_card_widget.dart';
//import 'package:yunzhixiao_business_client/uis/widgets/order_card_widget.dart';
//import 'package:yunzhixiao_business_client/uis/widgets/skeleton_widget.dart';
//import 'package:yunzhixiao_business_client/view_model/order/order_home_info_model.dart';
//import 'package:yunzhixiao_business_client/view_model/order/order_model.dart';
//
//import 'package:yunzhixiao_business_client/models/order_category_type.dart';
//
//class OrderProcessTakePage extends StatefulWidget {
//  CategoryType categoryType;
//  OrderProcessTakePage({key, this.categoryType}) : super(key: key);
//  @override
//  State<StatefulWidget> createState() => _OrderProcessTakePageState();
//}
//
//class _OrderProcessTakePageState extends State<OrderProcessTakePage>
//    with AutomaticKeepAliveClientMixin {
//  @override
//  bool get wantKeepAlive => false;
//  RandomColor _randomColor = RandomColor();
//
//  @override
//  Widget build(BuildContext context) {
//    super.build(context);
//    var theme = Theme.of(context);
//    final size = MediaQuery.of(context).size;
//    final width = size.width;
//    final height = size.height;
//
//    return ProviderWidget<OrderListModel>(
//      builder: (context, model, child) {
//        if (model.busy) {
//          return ViewStateBusyWidget();
//        } else if (model.error) {
//          return ViewStateErrorWidget(
//              error: model.viewStateError, onPressed: model.initData);
//        } else if (model.empty) {
//          return ViewStateEmptyWidget(onPressed: model.initData);
//        }
//        if (model.empty) {
//          return Container();
//        } else {
//          return SmartRefresher(
//              controller: model.refreshController,
//              header: WaterDropMaterialHeader(),
//              onRefresh: model.refresh,
//              enablePullUp: true,
//              onLoading: model.loadMore,
//              child: CustomScrollView(
//                slivers: <Widget>[
//                  SliverPadding(
//                    padding: EdgeInsets.only(left: 12, right: 12, top: 10),
//                    sliver: SliverGrid.count(
//                      childAspectRatio: 1,
//                      crossAxisCount: 5,
//                      children: model.list
//                          .asMap()
//                          .map((i, element) {
//                            return MapEntry(
//                                i,
//                                InkWell(
//                                  onTap: () {
//                                    showModalBottomSheet(
//                                        backgroundColor: Colors.transparent,
//                                        context: context,
//                                        builder: (context) {
//                                          return StatefulBuilder(
//                                              builder: (context, state) {
//                                            return Container(
//                                              height: MediaQuery.of(context)
//                                                      .size
//                                                      .height /
//                                                  2,
//                                              child: OrderCard(
//                                                  order: model.list[i],
//                                                  action: <Widget>[
//                                                    GestureDetector(
//                                                      child: Container(
//                                                        padding:
//                                                            const EdgeInsets
//                                                                .all(10),
//                                                        decoration:
//                                                            BoxDecoration(
//                                                                color: Colors
//                                                                    .white,
//                                                                boxShadow: [
//                                                                  BoxShadow(
//                                                                    color: Colors
//                                                                        .black12,
//                                                                    offset:
//                                                                        Offset(
//                                                                            0,
//                                                                            2.5),
//                                                                    blurRadius:
//                                                                        5,
//                                                                  ),
//                                                                ],
//                                                                borderRadius: BorderRadius
//                                                                    .all(Radius
//                                                                        .circular(
//                                                                            3))),
//                                                        width: 100,
//                                                        alignment:
//                                                            Alignment.center,
//                                                        child: Text('申请售后'),
//                                                      ),
//                                                    ),
//                                                    SizedBox(
//                                                      width: 20,
//                                                    ),
//                                                    Expanded(
//                                                      child: GestureDetector(
//                                                        child: Container(
//                                                          padding:
//                                                              const EdgeInsets
//                                                                  .all(10),
//                                                          decoration:
//                                                              BoxDecoration(
//                                                                  color: theme
//                                                                      .primaryColor,
//                                                                  boxShadow: [
//                                                                    BoxShadow(
//                                                                      color: Colors
//                                                                          .black12,
//                                                                      offset:
//                                                                          Offset(
//                                                                              0,
//                                                                              2.5),
//                                                                      blurRadius:
//                                                                          5,
//                                                                    ),
//                                                                  ],
//                                                                  borderRadius:
//                                                                      BorderRadius.all(
//                                                                          Radius.circular(
//                                                                              3))),
//                                                          alignment:
//                                                              Alignment.center,
//                                                          child: Text(
//                                                            '完成取餐',
//                                                            style: TextStyle(
//                                                                color: Colors
//                                                                    .white),
//                                                          ),
//                                                        ),
//                                                        onTap: () {
//                                                          model
//                                                              .archiveTakeOrder(
//                                                                  model.list[i]
//                                                                      .id,
//                                                                  context);
//                                                          Navigator.pop(
//                                                              context);
//                                                        },
//                                                      ),
//                                                    )
//                                                  ]),
//                                            );
//                                          });
//                                        });
//                                  },
//                                  child: Padding(
//                                    padding: const EdgeInsets.all(2.0),
//                                    child: MyCard(
//                                      borderRadius: BorderRadius.circular(8),
//                                      color: theme.primaryColor,
//                                      child: Center(
//                                          child: Text(
//                                        element.serviceNumber.toString(),
//                                        style: TextStyle(
//                                            color: Colors.white, fontSize: 32),
//                                      )),
//                                    ),
//                                  ),
//                                ));
//                          })
//                          .values
//                          .toList(),
//                    ),
//                  ),
//                ],
//              ));
//        }
//      },
//      model: OrderListModel(
//        commodity_status: widget.categoryType.commodityStatus,
//        ordering: '-update',
//        status: 1
//      ),
//      onModelReady: (model) {
//        model.initData();
//      },
//    );
//  }
//}
