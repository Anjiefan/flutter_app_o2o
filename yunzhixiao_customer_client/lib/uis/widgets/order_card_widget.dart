
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_customer_client/commons/routers/router.dart';
import 'package:yunzhixiao_customer_client/models/order.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/image_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/my_card_widget.dart';
import 'package:yunzhixiao_customer_client/utils/chat_utils.dart';
import 'package:yunzhixiao_customer_client/view_model/order_model.dart';

class OrderCard<T extends OrderListModel> extends StatelessWidget{
  Order order;
  OrderCard({this.order});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<T>(
      builder: (context,model,child){
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 7),
          child: GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, RouteName.orderDetail, arguments: order.id);
            },
            child: MyCard(
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              GestureDetector(
                                child: Container(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5.0),
                                      child:
                                      WrapperImage(
                                        url:
                                        order.shop.logo,
                                        width: 40,
                                        height: 40,
                                      )
                                  ),
                                ),
                                onTap: (){
                                  Navigator.pushNamed(
                                      context, RouteName.homeShopDetail, arguments:order.shop.id).then((result){
                                  });
                                },
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                GestureDetector(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(order.shop.name, style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 14
                                                      ),),
                                                      SizedBox(width: 5,),
                                                      Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey,),
                                                    ],
                                                  ),
                                                  onTap: (){
                                                    Navigator.pushNamed(
                                                        context, RouteName.homeShopDetail, arguments:order.shop.id).then((result){
                                                    });
                                                  },
                                                ),




//
                                              ],
                                            ),
                                          ),

                                          Container(child: Text(order.commodityStatus??'等待支付', style: TextStyle(fontSize: 12,color: Colors.black54),),)
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(child: Text('餐号：${order.serviceNumber}', style: TextStyle(fontSize: 12,color: Colors.black54),),),

                                          Container(child: Text('${order.date}', style: TextStyle(fontSize: 12,color: Colors.black54),),)
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Divider(height: 0,),
                                      SizedBox(height: 15,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("${order.num}件商品",style: TextStyle(fontSize: 12,),),
                                          Text("¥${order.discountMoney+order.serviceMoney}",),
                                        ],
                                      ),

                                    ],
                                  )
                              ),
                            ],
                          ),

                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [Expanded(child: Container())]..addAll(
                            get_bottun(context,model)
                        ),
                      )


                    ]
//                      ..addAll(),
                  ),
                )),
          ),
        );
      },
    );

  }
  List<Widget> get_bottun(BuildContext context,T model){
    switch(order.commodityStatusId){

      case -1:
        return [ GestureDetector(
          onTap: (){
            model.askCancel(order.id,context, needRefund: false);
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: Colors.black38,
                    width: 0.5)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
              child: Text(
                "取消订单",
                style: TextStyle(
                  fontSize: 13,
                    color: Colors.black45
                ),
              ),
            ),
          ),
        )];
      case 0:
        List<Widget> buttons=[];
        if(order.isSlow==false){
          buttons.add(GestureDetector(
            onTap: (){
              model.reminderOrder(order.id,context);
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: Colors.black38,
                      width: 0.5)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                child: Text(
                  "申请催单",
                  style: TextStyle(
                    fontSize: 13,
                      color: Colors.black45
                  ),
                ),
              ),
            ),
          ));
        }

        if(order.isCancel==false){
          if(buttons.length>0){
            buttons.add(SizedBox(width: 10,));
          }
          buttons.add(GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, RouteName.orderCancel, arguments: order.id).then((value){
                model.refresh();
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: Colors.black38,
                      width: 0.5)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                child: Text(
                  "取消订单",
                  style: TextStyle(
                    fontSize: 13,
                      color: Colors.black45
                  ),
                ),
              ),
            ),
          ));
        }
        else{
          if(buttons.length>0){
            buttons.add(SizedBox(width: 10,));
          }
          buttons.add(GestureDetector(
            onTap: (){
              //TODO 联系客服
              ChatUtils.qqChat(context);
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: Colors.black38,
                      width: 0.5)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                child: Text(
                  "联系客服",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black45
                  ),
                ),
              ),
            ),
          ));
        }
        return buttons;
      case 1:
        return [
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, RouteName.orderQRCode,arguments: [order]).then((value){
                model.refresh();
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: Colors.black38,
                      width: 0.5)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                child: Text(
                  "出示餐号",
                  style: TextStyle(
                    fontSize: 13,
                      color: Colors.black45
                  ),
                ),
              ),
            ),
          )
        ];
      case 2:
        return [
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, RouteName.orderCancel, arguments: order.id).then((value){
                model.refresh();
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: Colors.black38,
                      width: 0.5)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                child: Text(
                  "取消订单",
                  style: TextStyle(
                    fontSize: 13,
                      color: Colors.black45
                  ),
                ),
              ),
            ),
          )
        ];
      case 3:
        return [
          GestureDetector(
            onTap: (){
              model.cancelAsk(order.id,context);
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: Colors.black38,
                      width: 0.5)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                child: Text(
                  "取消申请",
                  style: TextStyle(
                    fontSize: 13,
                      color: Colors.black45
                  ),
                ),
              ),
            ),
          )
        ];
      case 4:
        if(order.isComment==false){
          return  [GestureDetector(
            onTap: (){
              //TODO 评论订单
              Navigator.pushNamed(context, RouteName.orderComment,arguments: [order,model]).then((value){
                model.refresh();
              });

            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: Colors.black38,
                      width: 0.5)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                child: Text(
                  "评论订单",
                  style: TextStyle(
                    fontSize: 13,
                      color: Colors.black45
                  ),
                ),
              ),
            ),
          )];
        }
        return [];
      case 5:
        return [];
      case 6:
        if(order.isComment==false){
          return  [GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, RouteName.orderComment,arguments: [order,model]).then((value){
                model.refresh();
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: Colors.black38,
                      width: 0.5)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                child: Text(
                  "评论订单",
                  style: TextStyle(
                    fontSize: 13,
                      color: Colors.black45
                  ),
                ),
              ),
            ),
          )];
        }
        return [];

      default:
        return [ GestureDetector(
          onTap: (){
            Navigator.of(context).pushNamed(RouteName.orderPay,
                arguments: [order]).then((value){
              model.refresh();
            });
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: Colors.black38,
                    width: 0.5)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
              child: Text(
                "完成付款",
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 13,

                ),
              ),
            ),
          ),
        )];
    }

  }
}
