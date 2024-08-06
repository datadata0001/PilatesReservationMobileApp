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
                ],
              ).expand(flex: 1),
              8.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${mData.title}', style: boldTextStyle(), softWrap: true, maxLines: 3),
                  8.height,
                  Text('${mData.content}', style: secondaryTextStyle()),
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
