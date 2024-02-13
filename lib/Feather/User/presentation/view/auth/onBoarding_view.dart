
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:m3k/Core/helper/shared_pref_services.dart';
import 'package:m3k/Core/translations/locale_keys.g.dart';
import 'package:m3k/Core/unit/app_router.dart';
import 'package:m3k/Core/unit/assets_data.dart';
import 'package:m3k/Core/unit/color_data.dart';
import 'package:m3k/Core/unit/constant_data.dart';
import 'package:m3k/Core/unit/size_data.dart';
import 'package:m3k/Core/unit/styles.dart';
import 'package:m3k/Core/unit/unit.dart';
import 'package:m3k/Core/widget/main_button_custom.dart';
import 'package:m3k/Feather/User/presentation/manager/user_cubit.dart';
import 'package:m3k/Feather/User/presentation/manager/user_state.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}
class _OnBoardingViewState extends State<OnBoardingView> {


  PageController pageController=PageController();

  List<String> image=['',AssetsData.onBoardingOneImage,AssetsData.onBoardingTwoImage];
  List<String> title=[LocaleKeys.kWeAdvanceWithTechnology.tr(),LocaleKeys.kEaseAndCommunication.tr(),LocaleKeys.kThePowerOfExcellence.tr()];
  List<String> desc=['',LocaleKeys.kDescOnBoardingTwo.tr(),LocaleKeys.kDescOnBoardingThree.tr()];

  bool isLast=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocBuilder<UserCubit,UserState>(
            builder: (context,state){
              return Padding(
                padding: EdgeInsets.all(SizeData.s20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: SizeData.s30,),
                    AspectRatio(
                      aspectRatio: 1/0.1,
                      child: Image.asset(AssetsData.logoImage),
                    ),
                    SizedBox(height: SizeData.s30,),
                    Expanded(
                      child: PageView.builder(
                          controller: pageController,
                          itemCount: image.length,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (int val){
                            if(val==image.length-1){
                              isLast=true;
                            }else{
                              isLast=false;
                            }
                          },
                          itemBuilder: (context,index){
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    index!=0?ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: Image.asset(image[index],
                                          fit: BoxFit.fill,
                                          width: Unit(context).getWidthSize*0.9,
                                          height: Unit(context).getWidthSize*0.65),
                                    ):SizedBox(
                                        height: Unit(context).getWidthSize*0.65
                                    ),
                                    SizedBox(height: SizeData.s15,),
                                    Text(title[index],
                                        style: Styles.textStyle24.copyWith(
                                            fontSize: Unit(context).getWidthSize*0.074,
                                          color: ColorData.blackColor
                                        ),textAlign: TextAlign.center),
                                    SizedBox(height: SizeData.s15,),
                                    Text(desc[index],
                                        style: Styles.textStyle22.copyWith(
                                            fontSize: Unit(context).getWidthSize*0.058,
                                        ),
                                        textAlign: TextAlign.center),
                                    const SizedBox(height: 20,),
                                  ],
                                )
                              ],
                            );
                          }),
                    ),
                    SmoothPageIndicator(
                      controller: pageController,
                      count: image.length,
                      axisDirection: Axis.horizontal,
                      effect: ExpandingDotsEffect(
                          activeDotColor: ColorData.primaryColor,
                          dotColor: ColorData.greyColor
                      ),
                    ),
                    SizedBox(height: SizeData.s20,),
                    MainButtonSecondCustom(
                      text: LocaleKeys.kStartNow.tr(),
                      fct: (){
                        if(isLast){
                          SharedPreferencesServices.setDate(key: ConstantData.kShowIntro, value: true);
                          context.go(AppRouter.kSelectLoginView);
                        }else{
                          pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.linear);
                        }
                      },
                    ),
                    SizedBox(height: SizeData.s20,),

                  ],
                ),
              );
            },
          )
      ),
    );
  }
}

