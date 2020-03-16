class SystemStaticInfo {
  HomePageData homePageData;
  EarnMoneyPageData earnMoneyPageData;
  StaticData staticData;
  SystemStaticInfo({this.homePageData, this.earnMoneyPageData, this.staticData});

  SystemStaticInfo.fromJson(Map<String, dynamic> json) {
    homePageData = json['home_page_data'] != null
        ? new HomePageData.fromJson(json['home_page_data'])
        : null;
    earnMoneyPageData = json['earn_money_page_data'] != null
        ? new EarnMoneyPageData.fromJson(json['earn_money_page_data'])
        : null;
    staticData = json['static_data'] != null
        ? new StaticData.fromJson(json['static_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.homePageData != null) {
      data['home_page_data'] = this.homePageData.toJson();
    }
    if (this.earnMoneyPageData != null) {
      data['earn_money_page_data'] = this.earnMoneyPageData.toJson();
    }
    if (this.staticData != null) {
      data['static_data'] = this.staticData.toJson();
    }
    return data;
  }
}
class StaticData {
  String serviceQq;
  String website;
  String share;
  StaticData({this.website,this.share,this.serviceQq});

  StaticData.fromJson(Map<String, dynamic> json) {
    serviceQq = json['service_qq'];
    website = json['website'];
    share = json['share'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_qq'] = this.serviceQq;
    data['website'] = this.website;
    data['share'] = this.share;
    return data;
  }
}
class HomePageData {
  List<SwiperPage> swiperPage;
  List<CateTypes> cateTypes;

  HomePageData({this.swiperPage, this.cateTypes});

  HomePageData.fromJson(Map<String, dynamic> json) {
    if (json['swiper_page'] != null) {
      swiperPage = new List<SwiperPage>();
      json['swiper_page'].forEach((v) {
        swiperPage.add(new SwiperPage.fromJson(v));
      });
    }
    if (json['cate_types'] != null) {
      cateTypes = new List<CateTypes>();
      json['cate_types'].forEach((v) {
        cateTypes.add(new CateTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.swiperPage != null) {
      data['swiper_page'] = this.swiperPage.map((v) => v.toJson()).toList();
    }
    if (this.cateTypes != null) {
      data['cate_types'] = this.cateTypes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SwiperPage {
  String url;
  String nav;
  bool isWeb;
  String name;
  SwiperPage({this.url, this.nav, this.isWeb,this.name});

  SwiperPage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    nav = json['nav'];
    isWeb = json['is_web'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['nav'] = this.nav;
    data['is_web'] = this.isWeb;
    data['name'] = this.name;
    return data;
  }
}

class CateTypes {
  String name;
  String image;
  int id;
  bool isWeb;
  String web;

  CateTypes({this.name, this.image, this.id, this.isWeb, this.web});

  CateTypes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    id = json['id'];
    isWeb = json['is_web'];
    web = json['web'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['id'] = this.id;
    data['is_web'] = this.isWeb;
    data['web'] = this.web;
    return data;
  }
}

class EarnMoneyPageData {
  List<SwiperPage> swiperPage;

  EarnMoneyPageData({this.swiperPage});

  EarnMoneyPageData.fromJson(Map<String, dynamic> json) {
    if (json['swiper_page'] != null) {
      swiperPage = new List<SwiperPage>();
      json['swiper_page'].forEach((v) {
        swiperPage.add(new SwiperPage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.swiperPage != null) {
      data['swiper_page'] = this.swiperPage.map((v) => v.toJson()).toList();
    }
    return data;
  }
}