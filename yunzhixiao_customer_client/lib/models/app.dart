/// CheckApp更新接口
class AppUpdateInfo {
  String buildBuildVersion;
  String forceUpdateVersion;
  String forceUpdateVersionNo;
  bool needForceUpdate;
  String downloadURL;
  bool buildHaveNewVersion;
  String buildVersionNo;
  String buildVersion;
  String buildShortcutUrl;
  String buildUpdateDescription;

  static AppUpdateInfo fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    AppUpdateInfo pgyerApiBean = AppUpdateInfo();
    pgyerApiBean.buildBuildVersion = map['buildBuildVersion'];
    pgyerApiBean.forceUpdateVersion = map['forceUpdateVersion'];
    pgyerApiBean.forceUpdateVersionNo = map['forceUpdateVersionNo'];
    pgyerApiBean.needForceUpdate = map['needForceUpdate'];
    pgyerApiBean.downloadURL = map['downloadURL'];
    pgyerApiBean.buildHaveNewVersion = map['buildHaveNewVersion'];
    pgyerApiBean.buildVersionNo = map['buildVersionNo'];
    pgyerApiBean.buildVersion = map['buildVersion'];
    pgyerApiBean.buildShortcutUrl = map['buildShortcutUrl'];
    pgyerApiBean.buildUpdateDescription = map['buildUpdateDescription'];
    return pgyerApiBean;
  }

  Map toJson() => {
    "buildBuildVersion": buildBuildVersion,
    "forceUpdateVersion": forceUpdateVersion,
    "forceUpdateVersionNo": forceUpdateVersionNo,
    "needForceUpdate": needForceUpdate,
    "downloadURL": downloadURL,
    "buildHaveNewVersion": buildHaveNewVersion,
    "buildVersionNo": buildVersionNo,
    "buildVersion": buildVersion,
    "buildShortcutUrl": buildShortcutUrl,
    "buildUpdateDescription": buildUpdateDescription,
  };
}
