import 'package:flutter/material.dart';
import 'package:flutter_app/modelgen/duyuru.g.dart';
import 'package:flutter_app/pages/NBAnnouncementDetailsScreen.dart';
import 'package:flutter_app/utils/NBColors.dart';
import 'package:flutter_app/utils/NBWidgets.dart';
import 'package:nb_utils/nb_utils.dart';


class NBAnnouncementComponent extends StatefulWidget {
  static String tag = '/NBAudioNewsComponent';

  final List<Duyuru>? list;

  NBAnnouncementComponent({this.list});

  @override
  NBAnnouncementComponentState createState() => NBAnnouncementComponentState();
}

class NBAnnouncementComponentState extends State<NBAnnouncementComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {

  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: widget.list!.length,
      padding: EdgeInsets.all(16),
      itemBuilder: (context, index) {
        Duyuru mData = widget.list![index];
        return Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  commonCachedNetworkImage('${mData}', height: 100, fit: BoxFit.fill).cornerRadiusWithClipRRect(16),
                  Container(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    decoration: boxDecorationWithRoundedCorners(backgroundColor: black.withOpacity(0.2)),
                    child: Text('${mData}', style: primaryTextStyle(color: white, size: 14)),
                  ),
                ],
              ).expand(flex: 1),
              8.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${mData}', style: boldTextStyle(color: NBPrimaryColor)),
                  Text('${mData.title}', style: boldTextStyle(), softWrap: true, maxLines: 3),
                  8.height,
                  Text('${mData}', style: secondaryTextStyle()),
                ],
              ).expand(flex: 2),
            ],
          ),
        ).onTap(
          () {
            NBAnnouncementDetailsScreen(mAnnouncementList: mData).launch(context);
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
