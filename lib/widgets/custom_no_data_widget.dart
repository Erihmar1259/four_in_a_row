
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_text.dart';

class CustomNoDataWidget extends StatelessWidget {
  const CustomNoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(text:"No Data" ,fontSize: 14.sp,fontWeight: FontWeight.bold,),
    );
  }
}
