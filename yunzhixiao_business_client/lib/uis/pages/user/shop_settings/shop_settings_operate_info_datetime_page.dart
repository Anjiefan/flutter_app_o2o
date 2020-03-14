import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yunzhixiao_business_client/uis/helpers/navigator_helper.dart';

class OperateTimeItem {
  final int startHours;
  final int startMinutes;
  final int endHours;
  final int endMinutes;

  OperateTimeItem(
      this.startHours, this.startMinutes, this.endHours, this.endMinutes);
}

class ShopSettingsOperateInfoDateTimePage extends StatefulWidget {
  ShopSettingsOperateInfoDateTimePage(
      {Key key,
      @required this.title,
      this.startHours,
      this.startMinutes,
      this.endHours,
      this.endMinutes})
      : super(key: key);

  final String title;
  final startHours;
  final startMinutes;
  final endHours;
  final endMinutes;

  @override
  _ShopSettingsOperateInfoDateTimePageState createState() =>
      _ShopSettingsOperateInfoDateTimePageState();
}

class _ShopSettingsOperateInfoDateTimePageState
    extends State<ShopSettingsOperateInfoDateTimePage> {
  var startTimeController = TextEditingController();
  var endTimeController = TextEditingController();

  var isFullDay = false;

  @override
  void initState() {
    super.initState();
    startTimeController.text = "${widget.startHours}:${widget.startMinutes}";
    endTimeController.text = "${widget.endHours}:${widget.endMinutes}";
  }

  @override
  void dispose() {
    startTimeController.dispose();
    endTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                    Container(
                      color: Theme.of(context).primaryColor,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                '24小时营业',
                                style: TextStyle(),
                              ),
                              trailing: CupertinoSwitch(
                                  value: isFullDay,
                                  activeColor: Theme.of(context).primaryColor,
                                  onChanged: (value) {
                                    setState(() {
                                      isFullDay = value;
                                      startTimeController.text = "0:00";
                                      endTimeController.text = "24:00";
                                    });
                                  }),
                            ),
                          ],
                        ),
                      ),
                    )
                  ])),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "设置营业时间",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                    Container(
                      color: Theme.of(context).primaryColor,
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 100,
                                child: Theme(
                                  data: ThemeData(
                                      primaryColor:
                                          Theme.of(context).primaryColor,
                                      hintColor: Colors.blue,
                                      scaffoldBackgroundColor: Colors.blue),
                                  child: TextField(
                                      enabled: !isFullDay,
                                      textAlign: TextAlign.center,
                                      onTap: () {
                                        showCupertinoModalPopup(
                                            context: context,
                                            builder: (context) {
                                              return _BottomPicker(
                                                  child: CupertinoTimerPicker(
                                                mode:
                                                    CupertinoTimerPickerMode.hm,
                                                //可以设置时分、时分秒和分秒三种模式
                                                initialTimerDuration: Duration(
                                                    hours: 1,
                                                    minutes: 35,
                                                    seconds: 50),
                                                // 默认显示的时间值
                                                minuteInterval: 5,
                                                // 分值间隔，必须能够被initialTimerDuration.inMinutes整除
                                                secondInterval: 10,
                                                // 秒值间隔，必须能够被initialTimerDuration.inSeconds整除，此时设置为10，则选择项为0、10、20、30、40、50六个值
                                                onTimerDurationChanged:
                                                    (duration) {
                                                  var minutes =
                                                      duration.inMinutes -
                                                          duration.inHours * 60;
                                                  startTimeController.text =
                                                      "${duration.inHours}:${minutes >= 0 && minutes < 10 ? "0$minutes" : minutes}";
                                                },
                                              ));
                                            });
                                      },
                                      maxLines: 1,
                                      controller: startTimeController,
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                          fillColor: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          contentPadding:
                                              const EdgeInsets.all(5.0),
                                          border: OutlineInputBorder())),
                                ),
                              ),
                              Text(
                                "    至    ",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: 100,
                                child: Theme(
                                  data: ThemeData(
                                      primaryColor:
                                          Theme.of(context).primaryColor,
                                      hintColor: Colors.blue,
                                      scaffoldBackgroundColor: Colors.blue),
                                  child: TextField(
                                      enabled: !isFullDay,
                                      textAlign: TextAlign.center,
                                      onTap: () {
                                        showCupertinoModalPopup(
                                            context: context,
                                            builder: (context) {
                                              return _BottomPicker(
                                                  child: CupertinoTimerPicker(
                                                mode:
                                                    CupertinoTimerPickerMode.hm,
                                                //可以设置时分、时分秒和分秒三种模式
                                                initialTimerDuration: Duration(
                                                    hours: 1,
                                                    minutes: 35,
                                                    seconds: 50),
                                                // 默认显示的时间值
                                                minuteInterval: 5,
                                                // 分值间隔，必须能够被initialTimerDuration.inMinutes整除
                                                secondInterval: 10,
                                                // 秒值间隔，必须能够被initialTimerDuration.inSeconds整除，此时设置为10，则选择项为0、10、20、30、40、50六个值
                                                onTimerDurationChanged:
                                                    (duration) {
                                                  var minutes =
                                                      duration.inMinutes -
                                                          duration.inHours * 60;
                                                  endTimeController.text =
                                                      "${duration.inHours}:${minutes >= 0 && minutes < 10 ? "0$minutes" : minutes}";
                                                },
                                              ));
                                            });
                                      },
                                      maxLines: 1,
                                      controller: endTimeController,
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                          fillColor: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          contentPadding:
                                              const EdgeInsets.all(5.0),
                                          border: OutlineInputBorder())),
                                ),
                              ),
                            ],
                          )),
                    )
                  ])),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Container(
                  height: 50,
                  width: 250,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      String startHoursStr =
                          startTimeController.text.split(':')[0];
                      String startMinutesStr =
                          startTimeController.text.split(':')[1];
                      String endHoursStr = endTimeController.text.split(':')[0];
                      String endMinutesStr =
                          endTimeController.text.split(':')[1];
                      NavigatorHelper.goBackWithParams(
                          context,
                          OperateTimeItem(
                              int.parse(startHoursStr),
                              int.parse(startMinutesStr),
                              int.parse(endHoursStr),
                              int.parse(endMinutesStr)));
                    },
                    child: Text(
                      "确定修改",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomPicker extends StatelessWidget {
  const _BottomPicker({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.systemBackground.resolveFrom(context),
      child: DefaultTextStyle(
        style: TextStyle(
          color: CupertinoColors.label.resolveFrom(context),
          fontSize: 22.0,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: child,
          ),
        ),
      ),
    );
  }
}
