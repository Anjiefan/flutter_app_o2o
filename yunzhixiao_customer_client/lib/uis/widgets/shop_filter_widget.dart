

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_customer_client/view_model/home/shop_model.dart';

class ShopFilter extends StatefulWidget{
  final model;

  const ShopFilter({Key key, this.model}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ShopFilterState();
  }

}
class _ShopFilterState extends State<ShopFilter>{
  TabController tabController;
  @override
  void dispose() {
    valueNotifier.dispose();
    super.dispose();
  }
  List selectedChoices=[];
  ValueNotifier<int> valueNotifier = ValueNotifier(0);
  _buildChoiceList() {
    List<Widget> choices = List();
    ['首单优惠','锁客折扣','分享红包','满减促销'].forEach((item) {
      choices.add(Container(
        child: ChoiceChip(
          selectedColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.grey[400].withOpacity(0.65),
          labelStyle: TextStyle(color: Colors.black87,fontSize: 14),
          padding: EdgeInsets.symmetric(horizontal: 2),
          label: Text(item, style: TextStyle(color: Colors.white,fontSize: 14),),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
              if (selectedChoices.contains("首单优惠")) {
                  widget.model.hasLockCustomerFirstPay = 1;
              } else {
                widget.model.hasLockCustomerFirstPay = 0;
              }
              if (selectedChoices.contains("锁客折扣")) {
                widget.model.hasLockCustomer = 1;
              } else {
                widget.model.hasLockCustomer = 0;
              }
              if (selectedChoices.contains("分享红包")) {
                widget.model.hasInviteCustomer = 1;
              } else {
                widget.model.hasInviteCustomer = 0;
              }
              if (selectedChoices.contains("满减促销")) {
                widget.model.hasMoneyOff = 1;
              } else {
                widget.model.hasMoneyOff = 0;
              }
              widget.model.refresh();
            });
          },
        ),
      ));
    });
    return choices;
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    var theme = Theme.of(context);
    return Consumer<ShopListModel>(
      builder: (context,model,child){
        return  ValueListenableProvider<int>.value(
          value: valueNotifier,
          child: DefaultTabController(
            length: ['推荐','销量','好评'].length,
            initialIndex: valueNotifier.value,
            child: Builder(
              builder: (context) {
                if (tabController == null) {
                  tabController = DefaultTabController.of(context);
                  tabController.addListener(() {
                    valueNotifier.value = tabController.index;
                    String ordering = "";
                    if (tabController.index == 0){
                      ordering = "-sort_level";
                    } else if (tabController.index == 1){
                      ordering = "-sell_num_mounth";
                    } else if (tabController.index == 2){
                      ordering = "-like_comment_num";
                    }
                    model.onRefreshOrdering(ordering);
                  });
                }
                return  Container(

                  color: Colors.white,
                  width: width,
                  height: 105,
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    children: <Widget>[
                      TabBar(
                        labelPadding: EdgeInsets.only(left: 15,right: 15,top: 0,bottom: 0),
                        labelStyle: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),
                        unselectedLabelStyle: TextStyle(fontSize: 18),
                        labelColor: Colors.black,
                        indicatorColor:Colors.white,
                        isScrollable: true,
                        controller: tabController,
                        indicatorWeight: 1,
                        indicatorPadding:EdgeInsets.only(left: 16,right: 16),
                        tabs: ['推荐','销量','好评'].map((choice) {
                          return new Tab(
                            text: choice,
                          );
                        }).toList(),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  _buildChoiceList(),
                        ),
                      ),

                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                );

              },
            ),
          ),
        );
      },
    );


  }


}