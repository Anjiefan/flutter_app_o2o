

import 'package:flutter/material.dart';
import 'package:yunzhixiao_business_client/models/order.dart';
import 'package:yunzhixiao_business_client/providers/provider_widget.dart';
import 'package:yunzhixiao_business_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_business_client/uis/widgets/order_operate_detail_card_widget.dart';
import 'package:yunzhixiao_business_client/view_model/order/order_home_info_model.dart';
import 'package:yunzhixiao_business_client/view_model/order/order_model.dart';

class OrderDialogUtils<T extends OrderListModel>{
   orderDialog(BuildContext context,Order order, OrderHomeInfoModel orderHomeInfoModel){
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled:true,
        context: context,
        builder: (context) {
      return ProviderWidget<OrderListModel>(
          model: OrderListModel(),
          onModelReady: (model){
            model.loadOrderDetail(order.id);
            model.orderHomeInfoModel = orderHomeInfoModel;
            print("!!!onModelReady");
          },
          builder: (context,  model, child) {
            if (model.busy) {
              return Container(
                  height: MediaQuery.of(context)
                      .size
                      .height
                      / 1.35,
                  child: ViewStateBusyWidget());
            } else if (model.error && model.list.isEmpty) {
              return ViewStateErrorWidget(error: model.viewStateError, onPressed: model.initData);
            }
            return  StatefulBuilder(
                builder: (context, state) {
                  return Container(
                      height: MediaQuery.of(context)
                          .size
                          .height /
                          1.35,
                      child: OrderOperateCard<T>(
                        orderHomeInfoModel: orderHomeInfoModel,
                        order: model.order,bc: context,
                      ));
                });
          }
      );



        });
  }
}