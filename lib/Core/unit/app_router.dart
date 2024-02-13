
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:m3k/Core/helper/shared_pref_services.dart';
import 'package:m3k/Core/unit/constant_data.dart';
import 'package:m3k/Feather/User/presentation/manager/user_cubit.dart';
import 'package:m3k/Feather/User/presentation/view/auth/login_view.dart';
import 'package:m3k/Feather/User/presentation/view/auth/onBoarding_view.dart';
import 'package:m3k/Feather/User/presentation/view/auth/otp_code_view.dart';
import 'package:m3k/Feather/User/presentation/view/auth/register_amenities_view.dart';
import 'package:m3k/Feather/User/presentation/view/auth/register_beneficiary_view.dart';
import 'package:m3k/Feather/User/presentation/view/auth/select_login_view.dart';
import 'package:m3k/Feather/User/presentation/view/auth/terms_conditions_view.dart';
import 'package:m3k/Feather/User/presentation/view/layout_view.dart';


abstract class AppRouter {

  static const kOnBoardingView='/OnBoardingView';
  static const kSelectLoginView='/SelectLoginView';
  static const kLoginView='/LoginView';
  static const kOtpCodeView='/OtpCodeView';
  static const kRegisterAmenitiesView='/RegisterAmenitiesView';
  static const kRegisterBeneficiaryView='/RegisterBeneficiaryView';
  static const kTermsConditionsView='/TermsConditionsView';

  static const kLayoutView ='/LayoutView';


  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state){
          if(!(SharedPreferencesServices.getDate(key: ConstantData.kShowIntro,)??false)){
            return const OnBoardingView();
          }else{
            if(SharedPreferencesServices.getDate(key: ConstantData.kLogin,)??false){
              BlocProvider.of<UserCubit>(context).selectTypeLogin(SharedPreferencesServices.getDate(key: ConstantData.kTypeAccount));
              BlocProvider.of<UserCubit>(context).getProfile();
              return LayoutView();
            }else{
              return const SelectLoginView();
            }
          }

        },
      ),
      GoRoute(
        path: kSelectLoginView,
        builder: (context, state) =>const SelectLoginView(),
      ),
      GoRoute(
        path: kLoginView,
        builder: (context, state) =>LoginView(),
      ),
      GoRoute(
        path: kOtpCodeView,
        builder: (context, state) =>OtpCodeView(phoneNumber: state.extra as String ),
      ),
      GoRoute(
        path: kRegisterAmenitiesView,
        builder: (context, state) =>RegisterAmenitiesView(),
      ),
      GoRoute(
        path: kRegisterBeneficiaryView,
        builder: (context, state) =>RegisterBeneficiaryView(),
      ),
      GoRoute(
        path: kTermsConditionsView,
        builder: (context, state) =>const TermsConditionsView(),
      ),

      GoRoute(
        path: kLayoutView,
        builder: (context, state) =>LayoutView(),
      ),

    ],
  );
}