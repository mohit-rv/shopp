import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:machine_test/controller/onboarding_third_controller.dart';
import 'package:machine_test/route_management/routes.dart';

import '../../Utils/colors.dart';

class OnBoardingThirdView extends StatelessWidget {
  const OnBoardingThirdView({super.key});

  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    final heightSize = MediaQuery.of(context).size.height;
    return  GetBuilder(
        init: OnBoardingThirdController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor:AppColors.primary, // Background color
            body: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset(
                        'assets/images/onboarding3.png', // Make sure this asset is available
                        height:heightSize/2,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width:widthSize,
                        decoration: const BoxDecoration(
                            color:Colors.white,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 50,),
                              const AutoSizeText(
                                'HOME DELIVER SERVICE',
                                style: TextStyle(
                                  fontSize:17,
                                  fontWeight: FontWeight.bold,
                                  color:AppColors.secondary,
                                ),
                              ),
                              const SizedBox(height:40,),
                              const Padding(
                                padding: EdgeInsets.only(left:20,right:10),
                                child: AutoSizeText(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                                      'Pharetra quam elementum massa, viverra. Ut turpis consectetur.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize:13,color:Colors.grey,),
                                  maxLines:3,
                                ),
                              ),
                              const SizedBox(height:70,),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(homeScreen);
                                },
                                child: const AutoSizeText(
                                  'Skip >>',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: SizedBox(
                                    height: 80,
                                    width:80,
                                    child: FloatingActionButton(
                                        onPressed: () {
                                         Get.toNamed(loginScreen);
                                        },
                                        backgroundColor:AppColors.whiteColor,
                                        elevation: 0,
                                        child:Image.asset('assets/images/forword_arrow.png',height:100,width:100,)
                                    ),
                                  ),
                                ),
                              ),
                          
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
            ),
          );
        }
    );
  }
}
