import 'package:flutter/material.dart';

class NBBannerItemModel {
  String? image;

  NBBannerItemModel({this.image});
}

class NBDrawerItemModel {
  final String title;
  final Widget widget;
  final String userId; // Kullanıcı kimliği veya adı

  NBDrawerItemModel({
    required this.title,
    required this.widget,
    required this.userId,
  });
}



class NBSettingsItemModel {
  String? title;
  Widget? widget;

  NBSettingsItemModel({this.title, this.widget});
}

class NBLanguageItemModel {
  String image;
  String name;

  NBLanguageItemModel(this.image, this.name);
}

class NBNotificationItemModel {
  String title;
  bool isOn;

  NBNotificationItemModel(this.title, this.isOn);
}



class NBMembershipPlanItemModel {
  String timePeriod;
  String price;
  String text;

  NBMembershipPlanItemModel(this.timePeriod, this.price, this.text);
}



