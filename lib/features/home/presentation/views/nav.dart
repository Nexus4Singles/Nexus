import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nexus/core/colors.dart';
import 'package:provider/provider.dart';
import 'package:nexus/features/home/presentation/change_notifier/bottom_nav.dart';

class MainNav extends StatefulWidget {
  final int? initialPage;

  const MainNav({
    super.key,
    this.initialPage = 0,
  });

  @override
  State<StatefulWidget> createState() {
    return _MainNav();
  }
}

class _MainNav extends State<MainNav> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  PageController? controller;
  bool internet = false;

  // final _navController = BottomNavModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int currentPage = 0;
    controller = PageController(initialPage: currentPage);
    setState(() {
      controller = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavModel>(builder: (context, model, child) {
      return Scaffold(
          key: _scaffoldKey,
          extendBody: true,
          extendBodyBehindAppBar: true,
          bottomSheet: Container(
            margin: EdgeInsets.only(
              left: 15.sp,
              right: 15.sp,
              bottom: 15.sp,
            ),
            // height: 65.h,
            // color: black,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.r),
                  child: BottomAppBar(
                    elevation: 0,
                    shape: const CircularNotchedRectangle(),
                    color: black,
                    child: tabItemsRow(context, model),
                    //Theme.of(context).bottomAppBarColor,
                  ),
                ),
              ],
            ),
          ),
          body: PageView(
            controller: controller,
            onPageChanged: (index) {
              model.updateIndex(index);
            },
            physics: const NeverScrollableScrollPhysics(),
            children: model.navs,
          ));
    });
  }

  Widget tabItemsRow(context, BottomNavModel navController) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          TabItems(
            navController: navController,
            iconImage: Iconsax.home,
            iconImage2: Iconsax.home5,
            text: '',
            onTap: () => controller!.jumpToPage(0),
            currentIndex: 0,
          ),
          TabItems(
            navController: navController,
            iconImage: Iconsax.discover,
            iconImage2: Iconsax.discover5,
            text: '',
            onTap: () => controller!.jumpToPage(1),
            currentIndex: 1,
          ),
          TabItems(
            navController: navController,
            iconImage: Iconsax.heart,
            iconImage2: Iconsax.heart5,
            text: '',
            onTap: () => controller!.jumpToPage(2),
            currentIndex: 2,
          ),
          TabItems(
            navController: navController,
            iconImage: Iconsax.message,
            iconImage2: Iconsax.message5,
            text: '',
            onTap: () => controller!.jumpToPage(3),
            currentIndex: 3,
          ),
          TabItems(
            navController: navController,
            iconImage: Iconsax.profile_circle,
            iconImage2: Iconsax.profile_circle5,
            text: '',
            onTap: () => controller!.jumpToPage(4),
            currentIndex: 4,
          ),
        ],
      ),
    );
  }
}

class TabItems extends StatelessWidget {
  final IconData? iconImage;
  final IconData? iconImage2;
  final String? text;
  final Function()? onTap;
  final int? currentIndex;
  final BottomNavModel? navController;
  const TabItems(
      {Key? key,
      this.navController,
      this.iconImage,
      this.iconImage2,
      this.text,
      this.onTap,
      this.currentIndex})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavModel>(
      builder: (context, model, child) => Expanded(
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: navController!.currentIndex == currentIndex
                  ? white
                  : Colors.transparent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                navController!.currentIndex == currentIndex
                    ? Icon(
                        iconImage2!,
                        color: primary,
                      )
                    : Icon(
                        iconImage!,
                        color: white,
                      ),
                // if (Platform.isAndroid) const SizedBoxH10(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
