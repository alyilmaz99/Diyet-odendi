import 'package:d/core/base/view/base_view.dart';
import 'package:d/core/constant/color_constant.dart';
import 'package:d/product/router/router_constant.dart';
import 'package:d/view/home/main/viewmodel/main_viewmodel.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends MainViewModel {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      builder: (context, width, height, appBar) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorConst.appBgColorWhite,
            elevation: 0,
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    top: 5,
                  ),
                  child: IconButton(
                    icon: SvgPicture.asset('assets/svg/ham_menu.svg'),
                    onPressed: () => {
                      context.pushNamed(RouteConstants.settings),
                    },
                  ),
                ),
                const Spacer(
                  flex: 3,
                ),
              ],
            ),
          ),
          backgroundColor: ColorConst.appBgColorWhite,
          body: IndexedStack(
            index: MainViewModel.selectedIndex,
            children: MainViewModel.pages,
          ),
          bottomNavigationBar: DotNavigationBar(
            enablePaddingAnimation: false,
            marginR: const EdgeInsets.only(
              bottom: 10,
              right: 30,
              left: 30,
            ),
            dotIndicatorColor: ColorConst.createPageText,

            currentIndex: MainViewModel.selectedIndex,
            onTap: onItemTapped,
            // dotIndicatorColor: Colors.black,
            items: [
              /// Home
              DotNavigationBarItem(
                icon: SvgPicture.asset('assets/svg/main_page.svg'),
                selectedColor: Colors.purple,
              ),

              /// Likes
              DotNavigationBarItem(
                icon: SvgPicture.asset('assets/svg/recipe_page.svg'),
                selectedColor: Colors.pink,
              ),
              DotNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/create_page.svg',
                  width: 50,
                ),
                selectedColor: Colors.pink,
              ),

              /// Search
              DotNavigationBarItem(
                icon: const Icon(
                  Icons.fastfood_outlined,
                  size: 25,
                  color: Colors.black54,
                ),
                selectedColor: Colors.pink,
              ),

              /// Profile
              DotNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/profile_page.svg',
                ),
                selectedColor: Colors.pink,
              ),
            ],
          ),
        );
      },
    );
  }
}
