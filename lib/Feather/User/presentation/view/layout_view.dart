
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m3k/Core/translations/locale_keys.g.dart';
import 'package:m3k/Core/unit/color_data.dart';
import 'package:m3k/Feather/User/presentation/manager/user_cubit.dart';
import 'package:m3k/Feather/User/presentation/manager/user_state.dart';

class LayoutView extends StatelessWidget {
  const LayoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> listScreen=[
      const Center(child: Text('Home'),),
      BlocProvider.of<UserCubit>(context).isBeneficiary?const Center(child: Text('الحجوزات'),):const Center(child: Text('الطلبات'),),
      BlocProvider.of<UserCubit>(context).isBeneficiary?const Center(child: Text('الإشعارات'),):const Center(child: Text('المرافقين'),),
      BlocProvider.of<UserCubit>(context).isBeneficiary?const Center(child: Text('المرافقين'),):const Center(child: Text('الإشعارات'),),
    ];
    return BlocBuilder<UserCubit,UserState>(
        builder: (context,state){
          var cubit=UserCubit.get(context);

      return Scaffold(
        body: listScreen[cubit.indexLayout],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: LocaleKeys.kCity.tr()
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home'
            ),
          ],
          currentIndex: cubit.indexLayout,
          onTap: (val){
            cubit.changeIndexLayout(index: val);
          },
          backgroundColor: ColorData.whiteColor,
          elevation: 15,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: ColorData.greyRegularColor,
          selectedItemColor: ColorData.primaryColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),

      );
    });
  }
}
