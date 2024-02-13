
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:m3k/Core/unit/color_data.dart';

class LoadingAppCustom extends StatelessWidget {
  const LoadingAppCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Center(
        child: LoadingIndicator(
            indicatorType: Indicator.ballClipRotatePulse,
            colors: [ColorData.primaryColor.withOpacity(0.2),ColorData.primaryColor.withOpacity(0.5),ColorData.primaryColor],
            strokeWidth: 10,
            backgroundColor: ColorData.whiteColor,
            pathBackgroundColor: ColorData.whiteColor,
        ),
      ),
    );
  }
}
