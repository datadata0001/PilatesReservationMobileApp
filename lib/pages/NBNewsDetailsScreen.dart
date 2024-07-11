import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/modelgen/reformers.g.dart';
import 'package:flutter_app/utils/NBColors.dart';
import 'package:flutter_app/utils/NBImages.dart';
import 'package:flutter_app/utils/NBWidgets.dart';
import 'package:nb_utils/nb_utils.dart';


class NBNewsDetailsScreen extends StatefulWidget {
  static String tag = '/NBNewsDetailsScreen';

  final Reformers? newsDetails;

  NBNewsDetailsScreen({this.newsDetails});

  @override
  NBNewsDetailsScreenState createState() => NBNewsDetailsScreenState();
}

class NBNewsDetailsScreenState extends State<NBNewsDetailsScreen> {
  bool isFollowing = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: appStore.isDarkModeOn ? white : black),
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
            Text('${widget.newsDetails!.name}', style: boldTextStyle(color: NBPrimaryColor)),
            Row(
              children: [
                Text('${widget.newsDetails!.id}', style: boldTextStyle(size: 20)).expand(flex: 3),
                widget.newsDetails!.status!
                    ? IconButton(
                        icon: Icon(Icons.bookmark),
                        onPressed: () {
                          setState(
                            () {
                            },
                          );
                          toasty(context, 'Removed from Bookmark');
                        },
                      )
                    : IconButton(
                        icon: Icon(Icons.bookmark_border),
                        onPressed: () {
                          setState(
                            () {
                            },
                          );
                          toasty(context, 'Added to Bookmark');
                        },
                      ),
              ],
            ),
            16.height,
            ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text('by Jones Hawkins', style: boldTextStyle()),
              subtitle: Text('12 jan 2021', style: secondaryTextStyle()),
              leading: CircleAvatar(backgroundImage: AssetImage(NBProfileImage)),
              trailing: AppButton(
                elevation: 0,
                text: isFollowing ? 'Following' : 'Follow',
                onTap: () {
                  setState(
                    () {
                      isFollowing = !isFollowing;
                    },
                  );
                },
                color: isFollowing ? grey.withOpacity(0.2) : black,
                textColor: isFollowing ? grey : white,
              ).cornerRadiusWithClipRRect(30),
            ),
            16.height,
            Text('${widget.newsDetails!.timegroup}', style: primaryTextStyle(), textAlign: TextAlign.justify),
            16.height,
            nbAppButtonWidget(
              context,
              'Comment',
              () {
              },
            ),
            16.height,
          ],
        ).paddingOnly(left: 16, right: 16),
      ),
    );
  }
}
