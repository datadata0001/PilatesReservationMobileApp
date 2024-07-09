import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/model.dart';
import 'package:flutter_app/utils/NBColors.dart';
import 'package:flutter_app/utils/NBDataProviders.dart';
import 'package:flutter_app/utils/NBImages.dart';
import 'package:flutter_app/utils/NBWidgets.dart';
import 'package:nb_utils/nb_utils.dart';


class NBSettingScreen extends StatefulWidget {
  static String tag = '/NBSettingScreen';

  @override
  NBSettingScreenState createState() => NBSettingScreenState();
}

class NBSettingScreenState extends State<NBSettingScreen> {
  List<NBSettingsItemModel> mSettingList = nbGetSettingItems();
  NBLanguageItemModel? result = NBLanguageItemModel(NBEnglishFlag, 'English');





  gotoNext(int index) async {
    result = await mSettingList[index].widget.launch(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: nbAppBarWidget(context, title: 'Ayarlar'),
      body: Column(
        children: [
          Container(
            height: 237,
            child: ListView.separated(
              padding: EdgeInsets.all(16),
              separatorBuilder: (_, index) {
                return Divider();
              },
              itemCount: mSettingList.length,
              itemBuilder: (_, index) {
                return Row(
                  children: [
                    Text('${mSettingList[index].title}', style: primaryTextStyle()).expand(),
                    index == 0
                        ? Row(
                            children: [
                              commonCachedNetworkImage('${result!.image}', height: 16),
                              8.width,
                              Text('${result!.name}', style: primaryTextStyle()),
                              Icon(Icons.navigate_next).paddingAll(8),
                            ],
                          )
                        : Icon(Icons.navigate_next).paddingAll(8),
                  ],
                ).onTap(
                  () {
                    if (index == 4 || index == 5) {
                      launchURL('https://www.google.com/');
                    } else if (index == 0) {
                      gotoNext(index);
                    } else {
                      mSettingList[index].widget.launch(context);
                    }
                  },
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Karanlık Mod', style: primaryTextStyle()).paddingOnly(left: 16),
              Switch(
                value: appStore.isDarkModeOn,
                activeColor: appColorPrimary,
                onChanged: (s) {
                  appStore.toggleDarkMode(value: s);
                },
              )
            ],
          ).onTap(
            () {
              appStore.toggleDarkMode();
            },
          ),
        ],
      ),
    );
  }
}
