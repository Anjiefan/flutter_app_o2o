import 'package:flutter/material.dart';
import 'package:yunzhixiao_business_client/view_model/shop_manage/commodity/commodity_type_model.dart';

class LeftCategoryNav extends StatefulWidget {
final CommodityTypeModel model;
final bool sort;
  LeftCategoryNav({Key key, this.model, this.sort}):super(key:key);
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  var listIndex = 0; //索引
  bool loading=false;

  _LeftCategoryNavState({Key key}):super();
  @override
  void initState() {
    super.initState();
    if(widget.model.list.length>0){
      widget.model.onSelectedCommodityType(commodityType: widget.model.list[0], index: 0, sort: widget.sort, isInit: true);

    }
  }
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final size =MediaQuery.of(context).size;
    final width =size.width;
    final height =size.height;

    return Container(
      width: width/4,
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Colors.black12))),
      child: ListView.builder(
        itemCount: widget.model.list.length,
        itemBuilder: (context, index) {
          bool point=false;
          if(widget.model.selectedCommodityType==null){
            point=false;
          }
          else{
            if(widget.model.selectedCommodityType.id == widget.model.list[index].id){
              point=true;
            }
            else{
              point=false;
            }
          }
          return InkWell(
            onTap: () {
                widget.model.onSelectedCommodityType(commodityType: widget.model.list[index], index: index, sort: widget.sort);
            },
            child: Column(
            children: <Widget>[
              Container(
                decoration: point?
                BoxDecoration(
                  color: Colors.white,
                  border: Border(left: BorderSide(color: theme.primaryColor.withOpacity(0.7),width: 5))
                )
                    :BoxDecoration(),
                alignment: Alignment.centerLeft,
                height: 60,
                padding: EdgeInsets.only(right: 10,left: 10),
                child: Text(
                  widget.model.list[index].name,style: theme.textTheme.subtitle,
                ),
              ),
//              Divider(height: 0.1,)
            ],
          ));
        },
      ),
    );
  }
}
