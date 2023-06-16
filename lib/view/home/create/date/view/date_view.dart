// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:d/core/base/view/base_view.dart';
import 'package:d/core/constant/color_constant.dart';
import 'package:d/product/router/router_constant.dart';
import 'package:d/product/service/database_service.dart';
import 'package:d/product/widget/create/date_button_widget.dart';
import 'package:d/view/home/create/date/viewmodel/date_viewmodel.dart';
import 'package:d/view/home/create/eating/model/eating_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DateView extends StatefulWidget {
  const DateView({super.key});

  @override
  State<DateView> createState() => _DateViewState();
}

class _DateViewState extends DateViewModel {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      builder: (context, width, height, appBar) {
        return Scaffold(
          backgroundColor: ColorConst.appBgColorWhite,
          body: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: ColorConst.mainBoxBg,
                      child: SizedBox(
                        height: height / 3,
                        width: width / 1.3,
                      ),
                    ),
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: ColorConst.textFieldBorder,
                      child: SizedBox(
                        height: height / 3.5,
                        width: width / 1.5,
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/svg/date.svg',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DateButtonWidget(
                width: width,
                height: height,
                title: 'Book an appointment',
                text: 'Available on 12th May 2021',
                function: () async {
                  showSheet(width, height);
                  print(
                      "=========================================================1");
                  print(
                      "=========================================================1.2");
                  List<Map<String, dynamic>> listFoods = await DatabaseService(
                          uid: FirebaseAuth.instance.currentUser!.uid)
                      .getFoods2();
                  Provider.of<FoodsModel>(context, listen: false)
                      .getFoods(listFoods: listFoods);
                  print(
                      "=========================================================2.1");
                  print(
                      "=========================================================2.2");

                  print(Provider.of<FoodsModel>(context, listen: false)
                      .foodsTitles);
                },
                icon: Icons.calendar_today,
              ),
              const SizedBox(
                height: 15,
              ),
              DateButtonWidget(
                width: width,
                height: height,
                title: 'Appointment Online',
                text: 'Available on 12th May 2021',
                function: () {
                  context.pushNamed(RouteConstants.appointment);
                },
                icon: Icons.ondemand_video_outlined,
              ),
              const SizedBox(
                height: 15,
              ),
              DateButtonWidget(
                width: width,
                height: height,
                title: 'Chat with the Doctor',
                text: 'Available 24x7',
                function: () {},
                icon: Icons.chat,
              ),
            ],
          ),
        );
      },
    );
  }
}
