// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:d/core/constant/color_constant.dart';
import 'package:d/product/router/router_constant.dart';
import 'package:d/product/service/database_service.dart';
import 'package:d/product/widget/create/lunch_container_widget.dart';
import 'package:d/view/home/create/date/view/date_view.dart';
import 'package:d/view/home/create/eating/model/eating_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

abstract class DateViewModel extends State<DateView> {
  late DateTime selectedDate;
  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void callFunction(String title) async {
    Provider.of<FoodsModel>(context, listen: false).selectedOgun = title;
    print("=========================================================1");
    print("=========================================================1.2");
    List<Map<String, dynamic>> listFoods =
        await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
            .getFoods2(title);
    Provider.of<FoodsModel>(context, listen: false)
        .getFoods(listFoods: listFoods);
    context.pushNamed(RouteConstants.eating);
  }

  void _resetSelectedDate() {
    selectedDate = DateTime.now().add(const Duration(days: 2));
  }

  Future<void> showSheet(
    double width,
    double height,
  ) async {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      isScrollControlled: true, // set this to true
      builder: (_) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          expand: false,
          builder: (_, controller) {
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: width / 1.2,
                  child: CalendarTimeline(
                    showYears: false,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(
                      const Duration(days: 365 * 4),
                    ),
                    onDateSelected: (date) => setState(
                      () => selectedDate = date,
                    ),
                    leftMargin: 10,
                    monthColor: ColorConst.sliderTitle,
                    dayColor: ColorConst.createPageText,
                    dayNameColor: ColorConst.appBgColorWhite,
                    activeDayColor: ColorConst.appBgColorWhite,
                    activeBackgroundDayColor: ColorConst.createPageText,
                    dotsColor: ColorConst.appBgColorWhite,
                    selectableDayPredicate: (date) => date.day != 23,
                    locale: 'tr',
                  ),
                ),
                const SizedBox(height: 20),
                LunchContainerWidget(
                  width: width,
                  height: height,
                  title: 'BreakFast',
                  text: 'Recommended 356-535 Kcal',
                  image: 'assets/images/breakfast.png',
                  function: () async {
                    callFunction('breakfast');
                  },
                ),
                LunchContainerWidget(
                  width: width,
                  height: height,
                  title: 'Lunch',
                  text: 'Recommended 356-731 Kcal',
                  image: 'assets/images/lunch.png',
                  function: () async {
                    callFunction('lunch');
                  },
                ),
                LunchContainerWidget(
                  width: width,
                  height: height,
                  title: 'Dinner',
                  text: 'Recommended 356-535 Kcal',
                  image: 'assets/images/dinner.png',
                  function: () {
                    callFunction('dinner');
                  },
                ),
                LunchContainerWidget(
                  width: width,
                  height: height,
                  title: 'Snacks',
                  text: 'Recommended 89 - 178 Kcal',
                  image: 'assets/images/snacks.png',
                  function: () => {
                    callFunction('snack'),
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
