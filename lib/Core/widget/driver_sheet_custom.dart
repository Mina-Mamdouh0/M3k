
import 'package:flutter/material.dart';

class DriverSheetCustom extends StatelessWidget {
  const DriverSheetCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: (){
          Navigator.pop(context);
        },
        child: Container(
          width: 50,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0XFFE8E8E8),
          ),
        ),
      ),
    );
  }
}
