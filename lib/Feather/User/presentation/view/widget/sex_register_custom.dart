
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';
import 'package:m3k/Core/translations/locale_keys.g.dart';
import 'package:m3k/Core/unit/color_data.dart';
import 'package:m3k/Core/unit/constant_data.dart';
import 'package:m3k/Core/unit/size_data.dart';
import 'package:m3k/Core/unit/styles.dart';
import 'package:m3k/Core/unit/unit.dart';
import 'package:m3k/Feather/User/presentation/manager/user_cubit.dart';
import 'package:m3k/Feather/User/presentation/manager/user_state.dart';

class SexRegisterCustom extends StatelessWidget {
  SexRegisterCustom({Key? key}) : super(key: key);

  GroupButtonController controller =GroupButtonController(selectedIndex: 0);
  final List<String> _listSex=[LocaleKeys.kMale.tr(),LocaleKeys.kFeminine.tr()];
  final List<String> _listKeySex=[SexRegisterEnum.male.name,SexRegisterEnum.female.name];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit,UserState>(
        builder: (context,state){
          var cubit=UserCubit.get(context);
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(LocaleKeys.kSex.tr(),
            style: Styles.textStyle22.copyWith(
                fontSize: Unit(context).getWidthSize*0.058,
                color: ColorData.greyRegularColor
            ),),
          SizedBox(height: SizeData.s15,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: GroupButton(
                  controller: controller,
                  isRadio: true,
                  enableDeselect: false,
                  options: const GroupButtonOptions(
                    direction: Axis.horizontal,
                    mainGroupAlignment: MainGroupAlignment.spaceBetween,
                    groupRunAlignment: GroupRunAlignment.spaceBetween,
                    crossGroupAlignment: CrossGroupAlignment.start,
                    groupingType: GroupingType.row,
                  ),
                  buttonIndexedBuilder: (select,index,context){
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(select?Icons.radio_button_checked:Icons.radio_button_off,
                            color: select?ColorData.primaryColor:ColorData.greyRegularColor,size: Unit(context).getWidthSize*0.053),
                        SizedBox(width: SizeData.s10,),
                        Text(_listSex[index],
                          style: Styles.textStyle22.copyWith(
                              fontSize: Unit(context).getWidthSize*0.058,
                              color: ColorData.greyRegularColor
                          ),),
                      ],
                    );

                  },
                  onSelected: (_,index,select){
                    cubit.changeSexRegister(sex: _listKeySex[index]);
                  },

                  buttons: _listSex,),
              ),
              const Spacer(),
            ],
          ),
        ],
      );
    });
  }
}
