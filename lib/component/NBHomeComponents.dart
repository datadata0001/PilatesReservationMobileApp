import 'package:flutter/material.dart';
import 'package:flutter_app/modelgen/reformers.g.dart';
import 'package:flutter_app/pages/NBNewsDetailsScreen.dart';
import 'package:flutter_app/utils/NBColors.dart';
import 'package:flutter_app/utils/NBWidgets.dart';
import 'package:nb_utils/nb_utils.dart';


class NBNewsComponent extends StatefulWidget {
  static String tag = '/NBNewsComponent';
  final List<Reformers>? list;

  NBNewsComponent({this.list});

  @override
  NBNewsComponentState createState() => NBNewsComponentState();
}

class NBNewsComponentState extends State<NBNewsComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {}

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
        Reformers mData = widget.list![index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${mData.name}', style: boldTextStyle(color: NBPrimaryColor)),
                Text('${mData.id}', style: boldTextStyle(), softWrap: true, maxLines: 3),
                8.height,
                Text('${mData.status}', style: secondaryTextStyle()),
              ],
            ).expand(flex: 2),
            4.width,
          ],
        ).onTap(
          () {
            NBNewsDetailsScreen(newsDetails: mData).launch(context);
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}