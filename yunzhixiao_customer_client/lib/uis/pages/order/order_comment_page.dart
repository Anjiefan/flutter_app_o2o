


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_customer_client/models/order.dart';
import 'package:yunzhixiao_customer_client/models/shop.dart';
import 'package:yunzhixiao_customer_client/providers/provider_widget.dart';
import 'package:yunzhixiao_customer_client/providers/view_state_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/circle_point_widget.dart';
import 'package:yunzhixiao_customer_client/uis/widgets/image_widget.dart';
import 'package:yunzhixiao_customer_client/view_model/home/shop_model.dart';
import 'package:yunzhixiao_customer_client/view_model/order_model.dart';

class OrderCommentPage extends StatefulWidget {
  Order order;
  OrderListModel orderListModel;
  OrderCommentPage({this.order,this.orderListModel});
  @override
  State<StatefulWidget> createState() => _OrderCommentStatePage();
}

class _OrderCommentStatePage extends State<OrderCommentPage>{
  TextEditingController controller = TextEditingController();
  int isGoodNotifier = 1;
  String message='';
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final size =MediaQuery.of(context).size;
    final width =size.width;
    final height =size.height;

    // TODO: implement build
    return  ProviderWidget<ShopCommentListModel>(
      builder: (context, model, child) {
        if (model.busy) {
          return ViewStateBusyWidget();
        } else if (model.error && model.list.isEmpty) {
          return ViewStateErrorWidget(
              error: model.viewStateError, onPressed: model.initData);
        }
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(

            title: Text(widget.order.shop.name),
            actions: <Widget>[
              InkWell(child:  Padding(
                padding: const EdgeInsets.only(top: 15,right: 20,left: 20),
                child: Container(
                  child: Text('发布',style: TextStyle(fontSize: 18),),
                ),
              ),onTap: () async {
                await model.comment(is_good: isGoodNotifier,order_model: 'GetOrder'
                    ,order_id: widget.order.id,message: message,context: context,model: widget.orderListModel);
                Navigator.pop(context);

              },)
            ],

          ),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child:ListTile(
                  leading: CirclePointWidget(),
                  title: Text(
                    '评论商家',
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                  subtitle: Text(
                    '您的反馈，帮助我们前进',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child:Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[

                      InkWell(
                        child: card(text: '不满意'
                            ,img: 'http://lc-aveFaAUx.cn-n1.lcfile.com/d8ad'
                                '73052076e3a755cd/%E4%B8%8D%E6%BB%A1%E6%84%8F.png'
                            ,type: 0),
                        onTap: (){
                          if(mounted)
                          setState(() {
                            isGoodNotifier=0;
                          });
                        },
                      ),
                      InkWell(
                        child: card(text: '满意',
                            img: 'http://lc-aveFaAUx.cn-n1.lcfile.com/d4bd6b840fea4d2dcd58/manyi.png'
                            ,type: 1),
                        onTap: (){
                          if(mounted)
                            setState(() {
                              isGoodNotifier=1;
                            });
                        },

                      ),

                    ],
                  ),
                ),

              ),

              SliverToBoxAdapter(
                child: Container(
                  width: width*0.8,

                  child: Row(
                    children: <Widget>[
                      Container(
                        width: width*0.1,
                      ),
                      Expanded(child: TextField(
                        readOnly: false,
                        style: TextStyle(color: Colors.black87,fontSize: 15),
                        controller: controller,
                        maxLines: 5,
                        maxLength: 50,
                        onChanged: (result) {
                          message =
                              controller.text;
                        },
                        decoration: InputDecoration(
                            hintText: '请输入您的评价，50字以内（选填）',
                            border: InputBorder.none,
                            hintMaxLines: 5
                        ),
                      )),
                      Container(
                        width: width*0.1,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
      model: ShopCommentListModel(widget.order.shop.id),
    );

  }

  Widget card({String text,String img,int type}){
    var theme = Theme.of(context);
    final size =MediaQuery.of(context).size;
    final width =size.width;
    final height =size.height;
    return Container(
      width: (width-2)*0.3,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: type==isGoodNotifier?[
            BoxShadow(blurRadius: 5.0,color: theme.primaryColor),
          ]:[
            BoxShadow(blurRadius: 1.0,color: Colors.black54),
          ]
      ),
      child: Column(
        children: <Widget>[
          Container(
            child: Text('${text}',style: TextStyle(color:type==isGoodNotifier?theme.primaryColor:Colors.black54),),
          ),
          SizedBox(height: 20,),
          Container(
            child: ClipOval(
                child: WrapperImage(
                  url: '${img}',
                  width: 80,
                  height: 80,
                )),
          ),
        ],
      ),
    );
  }

}