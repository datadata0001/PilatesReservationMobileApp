import 'package:flutter/material.dart';
import 'package:flutter_app/component/NBAnnouncementComponent.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/model.dart';
import 'package:flutter_app/modelgen/duyuru.g.dart';
import 'package:flutter_app/utils/NBColors.dart';
import 'package:flutter_app/utils/NBDataProviders.dart';
import 'package:flutter_app/utils/NBWidgets.dart';
import 'package:nb_utils/nb_utils.dart';


class NBAnnouncementScreen extends StatefulWidget {
  static String tag = '/NBAnnouncementScreen';



  @override
  NBAnnouncementScreenState createState() => NBAnnouncementScreenState();
}

class NBAnnouncementScreenState extends State<NBAnnouncementScreen> with SingleTickerProviderStateMixin {
  int pageIndex = 0;
  late List<Duyuru> mAnnouncementList;


  PageController? pageController;
  TabController? tabController;

  List<NBBannerItemModel> pages = nbGetBannerItems();

  @override
  void initState() {
    super.initState();
    mAnnouncementList = []; // Başlangıçta boş bir liste oluşturuldu
    init();
  }

  Future<void> init() async {

    mAnnouncementList = await nbGetAnnouncementDetails();
    setState(() {}); // State'i güncellemek için setState kullanılmalı




    
    pageController = PageController(initialPage: pageIndex, viewportFraction: 1);
    tabController = TabController(length: 5, vsync: this);
    

  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        physics: ScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: 350,
              iconTheme: IconThemeData(color: appStore.isDarkModeOn ? white : black),
              backgroundColor: context.cardColor,
              title: Text('Duyurular', style: boldTextStyle(size: 20)),
              centerTitle: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  margin: EdgeInsets.only(top: 100),
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        child: PageView(
                          controller: pageController,
                          children: List.generate(
                            pages.length,
                            (index) {
                              return Stack(
                                children: [
                                  commonCachedNetworkImage(
                                    pages[index].image!,
                                    fit: BoxFit.fill,
                                    width: context.width(),
                                  ).cornerRadiusWithClipRRect(16),
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    height: 200,
                                    padding: EdgeInsets.all(8),
                                    color: black.withOpacity(0.25),
                                    child: Row(
                                      children: [
                                        LinearProgressIndicator(
                                          backgroundColor: grey,
                                          value: 0.5,
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        ).expand(),
                                        8.width,
                                        Text('40:15', style: primaryTextStyle(size: 14, color: white)),
                                      ],
                                    ),
                                  ).cornerRadiusWithClipRRect(16),
                                ],
                              ).paddingOnly(left: 16, right: 16);
                            },
                          ),
                          onPageChanged: (value) {
                            setState(
                              () {
                                pageIndex = value;
                              },
                            );
                          },
                        ),
                      ),
                      8.height,
                      DotIndicator(
                        pageController: pageController!,
                        pages: pages,
                        indicatorColor: NBPrimaryColor,
                        unselectedIndicatorColor: gray,
                      ),
                      16.height,
                    ],
                  ),
                ),
              ),
              bottom: TabBar(
                controller: tabController,
                tabs: [
                  Tab(text: 'All News'),
                  Tab(text: 'Technology'),
                  Tab(text: 'Fashion'),
                  Tab(text: 'Sports'),
                  Tab(text: 'Science'),
                ],
                labelStyle: boldTextStyle(),
                labelColor: appStore.isDarkModeOn ? white : black,
                unselectedLabelStyle: primaryTextStyle(),
                unselectedLabelColor: grey,
                isScrollable: true,
                indicatorColor: NBPrimaryColor,
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.label,
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: tabController,
          children: [
            NBAnnouncementComponent(list: mAnnouncementList),
          ],
        ),
      ),
    );
  }
}