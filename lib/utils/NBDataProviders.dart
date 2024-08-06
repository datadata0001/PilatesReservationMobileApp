import 'package:flutter_app/main.dart';
import 'package:flutter_app/model.dart';
import 'package:flutter_app/modelgen/duyuru.g.dart';
import 'package:flutter_app/modelgen/reformers.g.dart';
import 'package:flutter_app/modelgen/users.g.dart';
import 'package:flutter_app/pages/NBAnnouncementDetailsScreen.dart';
import 'package:flutter_app/pages/NBAnnouncementScreen.dart';
import 'package:flutter_app/pages/NBChangePasswordScreen.dart';
import 'package:flutter_app/pages/NBCreateNewAnnouncementScreen.dart';
import 'package:flutter_app/pages/NBDays.dart';
import 'package:flutter_app/pages/NBEditProfileScreen.dart';
import 'package:flutter_app/pages/NBHomeScreen.dart';
import 'package:flutter_app/pages/NBLanguageScreen.dart';
import 'package:flutter_app/pages/NBMembershipScreen.dart';
import 'package:flutter_app/pages/NBNotificationSettingScreen.dart';
import 'package:flutter_app/pages/NBReformerDetailsScreen.dart';
import 'package:flutter_app/pages/NBSettingScreen.dart';
import 'package:flutter_app/pages/NBDropTakeScreen.dart';
import 'package:flutter_app/utils/NBImages.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

String details = 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
    'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,'
    ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. '
    'It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. '
    'It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing '
    'software like Aldus PageMaker including versions of Lorem Ipsum.\n\n'
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
    'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,'
    ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. '
    'It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. '
    'It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing '
    'software like Aldus PageMaker including versions of Lorem Ipsum.\n\n'
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
    'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,'
    ' when an unknown printer took a galley of type and scrambled it to make a type specimen book. '
    'It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. '
    'It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing '
    'software like Aldus PageMaker including versions of Lorem Ipsum.';

List<NBBannerItemModel> nbGetBannerItems() {
  List<NBBannerItemModel> bannerList = [];
  bannerList.add(NBBannerItemModel(image: NBNewsImage1));
  bannerList.add(NBBannerItemModel(image: NBNewsImage2));
  bannerList.add(NBBannerItemModel(image: NBNewsImage3));
  return bannerList;
}

List<NBDrawerItemModel> nbGetDrawerItems(String userId) {
  List<NBDrawerItemModel> drawerItems = [];
  drawerItems.add(NBDrawerItemModel(title: 'Anasayfa', userId: userId, widget: NBHomeScreen(userId:userId,),));
  drawerItems.add(NBDrawerItemModel(title: 'Ders İptal/Seçim', widget: NBDays(userId: userId), userId: userId));
  drawerItems.add(NBDrawerItemModel(title: 'Duyurular', widget: NBAnnouncementScreen(userId: '',), userId: userId));
  drawerItems.add(NBDrawerItemModel(title: 'Duyuru Oluştur', widget: NBCreateNewAnnouncemetScreen(supabaseClient: supabase), userId: userId));
  drawerItems.add(NBDrawerItemModel(title: 'Üyelik', widget: NBMembershipScreen(), userId: userId));
  drawerItems.add(NBDrawerItemModel(title: 'Ayarlar', widget: NBSettingScreen(), userId: userId));

  return drawerItems;
}






Future<List<Duyuru>> nbGetAnnouncementDetails() async {
  
  final supabase = Supabase.instance.client;
  
  final response = await supabase.from('duyuru').select();

  
  final List<Duyuru> tableModel =
      response.map((item) => Duyuru.fromMap(item)).toList();


  print(tableModel.length);
  return tableModel;
}


Future<List<Reformers>> nbGetReformersDetails() async {
  
  final supabase = Supabase.instance.client;
  
  final response = await supabase.from('reformers').select();

  
  final List<Reformers> tableModel =
      response.map((item) => Reformers.fromMap(item)).toList();


  print(tableModel.length);
  return tableModel;
}


Future<List<Users>> nbGetUserDetails() async {
  
  final supabase = Supabase.instance.client;
  
  final response = await supabase.from('users').select();

  
  final List<Users> tableModel =
      response.map((item) => Users.fromMap(item)).toList();


  print(tableModel.length);
  return tableModel;
}


/*
List<NBNewsDetailsModel> nbGetNewsDetails() {
  List<NBNewsDetailsModel> newsDetailsList = [];


  newsDetailsList.add(NBNewsDetailsModel(
    categoryName: 'Sports',
    title: 'NHL roundup: Mika Zibanejad\'s record night powers Rangers',
    date: '20 jan 2021',
    image: NBSportSNews1,
    details: details,
    time: '40:18',
    isBookmark: true,
  ));
  newsDetailsList.add(NBNewsDetailsModel(
    categoryName: 'Technology',
    title: 'Amazfit T-Rex Pro review: This fitness watch is in a league of its own',
    date: '20 jan 2021',
    image: NBTechNews1,
    details: details,
    time: '1:40:18',
  ));
  newsDetailsList.add(NBNewsDetailsModel(
    categoryName: 'Fashion',
    title: 'Amazfit T-Rex Pro review: This fitness watch is in a league of its own',
    date: '20 jan 2021',
    image: NBTechNews1,
    details: details,
    time: '40:00',
    isBookmark: true,
  ));
  newsDetailsList.add(NBNewsDetailsModel(
    categoryName: 'Science',
    title: 'NHL roundup: Mika Zibanejad\'s record night powers Rangers',
    date: '20 jan 2021',
    image: NBSportSNews1,
    details: details,
    time: '15:00',
    isBookmark: true,
  ));
  newsDetailsList.add(NBNewsDetailsModel(
    categoryName: 'Sports',
    title: 'Spring training roundup: Braves get past Rays',
    date: '20 Nov 2020',
    image: NBSportSNews2,
    details: details,
    time: '1:9:30',
  ));
  newsDetailsList.add(NBNewsDetailsModel(
    categoryName: 'Technology',
    title: 'Micromax In 1 review: Clean software gives this budget smartphone an edge',
    date: '20 Nov 2020',
    image: NBTechNews2,
    details: details,
    time: '1:9:30',
    isBookmark: true,
  ));
  newsDetailsList.add(NBNewsDetailsModel(
    categoryName: 'Fashion',
    title: 'Micromax In 1 review: Clean software gives this budget smartphone an edge',
    date: '20 Nov 2020',
    image: NBTechNews2,
    details: details,
    time: '40:00',
  ));
  newsDetailsList.add(NBNewsDetailsModel(
    categoryName: 'Science',
    title: 'Spring training roundup: Braves get past Rays',
    date: '20 Nov 2020',
    image: NBSportSNews2,
    details: details,
    time: '20:00',
  ));
  return newsDetailsList;
}
*/





List<NBSettingsItemModel> nbGetSettingItems() {
  List<NBSettingsItemModel> settingList = [];
  settingList.add(NBSettingsItemModel(title: 'Diller', widget: NBLanguageScreen()));
  settingList.add(NBSettingsItemModel(title: 'Profili Düzenle', widget: NBEditProfileScreen()));
  settingList.add(NBSettingsItemModel(title: 'Şifre Değiştir', widget: NBChangePasswordScreen()));
  settingList.add(NBSettingsItemModel(title: 'Bildirim Ayarları', widget: NBNotificationSettingScreen()));
  settingList.add(NBSettingsItemModel(title: 'Yardım ve Destek'));
  settingList.add(NBSettingsItemModel(title: 'Terms and Conditions'));
  return settingList;
}

List<NBLanguageItemModel> nbGetLanguageItems() {
  List<NBLanguageItemModel> languageList = [];
  languageList.add(NBLanguageItemModel(NBChineseFlag, 'Chinese'));
  languageList.add(NBLanguageItemModel(NBEnglishFlag, 'English'));
  languageList.add(NBLanguageItemModel(NBFrenchFlag, 'French'));
  languageList.add(NBLanguageItemModel(NBMelayuFlag, 'Melayu'));
  languageList.add(NBLanguageItemModel(NBSpainFlag, 'Spain'));
  return languageList;
}

List<NBNotificationItemModel> nbGetNotificationItems() {
  List<NBNotificationItemModel> notificationList = [];
  notificationList.add(NBNotificationItemModel('Uygulama Bildirimleri', true));
  notificationList.add(NBNotificationItemModel('Ders Saati Bildirimleri', true));
  notificationList.add(NBNotificationItemModel('İndirimler', false));
  notificationList.add(NBNotificationItemModel('Duyuru Bildirimleri', true));
  return notificationList;
}

List<NBMembershipPlanItemModel> nbGetMembershipPlanItems() {
  List<NBMembershipPlanItemModel> planList = [];
  planList.add(NBMembershipPlanItemModel('8 Seans', '\₺2000', 'Her Ay'));
  planList.add(NBMembershipPlanItemModel('12 Seans', '\₺2500', 'Her Ay'));
  return planList;
}


List<LanguageDataModel> languageList() {
  return [
    LanguageDataModel(id: 1, name: 'English', languageCode: 'en', fullLanguageCode: 'en-US', flag: 'images/flag/ic_us.png'),
    LanguageDataModel(id: 2, name: 'Hindi', languageCode: 'hi', fullLanguageCode: 'hi-IN', flag: 'images/flag/ic_hi.png'),
    LanguageDataModel(id: 3, name: 'Arabic', languageCode: 'ar', fullLanguageCode: 'ar-AR', flag: 'images/flag/ic_ar.png'),
    LanguageDataModel(id: 4, name: 'French', languageCode: 'fr', fullLanguageCode: 'fr-FR', flag: 'images/flag/ic_fr.png'),
  ];
}
