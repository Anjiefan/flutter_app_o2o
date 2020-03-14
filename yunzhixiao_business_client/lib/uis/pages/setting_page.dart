import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:launch_review/launch_review.dart';
import 'package:provider/provider.dart';
import 'package:yunzhixiao_business_client/generated/i18n.dart';
import 'package:yunzhixiao_business_client/view_model/theme_model.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var iconColor = Theme.of(context).accentColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).setting),
      ),
      body: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: <Widget>[

              SizedBox(
                height: 10,
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(S.of(context).settingFont),
                      Text(
                        ThemeModel.fontName(
                            Provider.of<ThemeModel>(context).fontIndex,
                            context),
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                  leading: Icon(
                    Icons.font_download,
                    color: iconColor,
                  ),
                  children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: ThemeModel.fontValueList.length,
                        itemBuilder: (context, index) {
                          var model = Provider.of<ThemeModel>(context);
                          return RadioListTile(
                            value: index,
                            onChanged: (index) {
                              model.switchFont(index);
                            },
                            groupValue: model.fontIndex,
                            title: Text(ThemeModel.fontName(index, context)),
                          );
                        })
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Material(
                color: Theme.of(context).cardColor,
                child: ListTile(
                  title: Text(S.of(context).rate),
                  onTap: () async {
                    LaunchReview.launch(
                        androidAppId: "cn.phoenixsky.funandroid",
                        iOSAppId: "1477299503");
                  },
                  leading: Icon(
                    Icons.star,
                    color: iconColor,
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Material(
                color: Theme.of(context).cardColor,
                child: ListTile(
                  title: Text(S.of(context).feedback),
                  onTap: () async {

                  },
                  leading: Icon(
                    Icons.feedback,
                    color: iconColor,
                  ),
                  trailing: Icon(Icons.chevron_right),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
