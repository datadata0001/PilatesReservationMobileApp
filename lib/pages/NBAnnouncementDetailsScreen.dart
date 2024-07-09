
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/modelgen/duyuru.g.dart';
import 'package:flutter_app/utils/NBColors.dart';
import 'package:flutter_app/utils/NBDataProviders.dart';
import 'package:flutter_app/utils/NBImages.dart';
import 'package:flutter_app/utils/NBWidgets.dart';
import 'package:nb_utils/nb_utils.dart';


class NBAnnouncementDetailsScreen extends StatefulWidget {
  static String tag = '/NBAnnouncementDetailsScreen';

  final Duyuru? audioDetails;

  NBAnnouncementDetailsScreen({this.audioDetails, required Duyuru mAnnouncementList});

  @override
  NBAnnouncementDetailsScreenState createState() => NBAnnouncementDetailsScreenState();
}

class NBAnnouncementDetailsScreenState extends State<NBAnnouncementDetailsScreen> {
  
  late List<Duyuru> mAnnouncemetList;





  @override
  void initState() {
    super.initState();
    mAnnouncemetList = []; // Başlangıçta boş bir liste oluşturuldu
    init();
  }

  Future<void> init() async {
    mAnnouncemetList = await nbGetAnnouncementDetails();
    setState(() {}); // State'i güncellemek için setState kullanılmalı

    
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: appStore.isDarkModeOn ? white : black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            finish(context);
          },
        ),
        elevation: 0,
        backgroundColor: context.cardColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.height,
            commonCachedNetworkImage(widget.audioDetails!.title, height: 200, width: context.width(), fit: BoxFit.cover).cornerRadiusWithClipRRect(16),
            16.height,
            Text('${widget.audioDetails!.title}', style: boldTextStyle(), textAlign: TextAlign.center),
            16.height,
            Row(
              children: [
                Text('10:20', style: primaryTextStyle(size: 14)),
                8.width,
                LinearProgressIndicator(
                  backgroundColor: grey.withOpacity(0.1),
                  value: 0.7,
                  valueColor: AlwaysStoppedAnimation<Color>(NBPrimaryColor),
                  minHeight: 5,
                ).expand(),
                8.width,
                Text('${widget.audioDetails!.title}', style: primaryTextStyle(size: 14)),
              ],
            ),
            16.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ImageIcon(AssetImage(NBRefreshIcon), size: 20),
                IconButton(icon: Icon(Icons.skip_previous), onPressed: () {}),
                Container(
                  decoration: boxDecorationWithRoundedCorners(backgroundColor: NBPrimaryColor),
                  child: IconButton(icon: Icon(Icons.pause), onPressed: () {}, color: white),
                ),
                IconButton(icon: Icon(Icons.skip_next), onPressed: () {}),
                ImageIcon(AssetImage(NBRefreshNextIcon), size: 20),
              ],
            ),
            16.height,
            Text('Description', style: boldTextStyle(size: 20)),
            8.height,
            Text('${widget.audioDetails!.title}', style: primaryTextStyle(), textAlign: TextAlign.justify),
            16.height,
          ],
        ).paddingOnly(left: 16, right: 16),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
