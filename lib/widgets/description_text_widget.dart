import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/constants.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  const DescriptionTextWidget({super.key, required this.text});

  @override
  _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  String? firstHalf;
  String? secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 100) {
      firstHalf = widget.text.substring(0, 100);
      secondHalf = widget.text.substring(100, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.0.h),
      child: secondHalf!.isEmpty
          ? Text(firstHalf!)
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(flag ? ("${firstHalf!}...") : (firstHalf! + secondHalf!),style: TextStyle(color: Colors.grey,fontSize: 16.sp)),
          InkWell(
            child: Text(
              flag ? "show more" : "show less",
              style: TextStyle(color: kPrimaryColor),
            ),
            onTap: () {
              setState(() {
                flag = !flag;
              });
            },
          ),
        ],
      ),
    );
  }
}