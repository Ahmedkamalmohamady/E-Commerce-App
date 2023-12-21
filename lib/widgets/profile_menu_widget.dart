import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shop_app/constants.dart';



class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    // required this.onPress,
    this.endIcon = true,
    this.textColor,
    this.trailing
  }) : super(key: key);
  final Widget?trailing;
  final String title;
  final IconData icon;
  // final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {


    var iconColor = kPrimaryColor;

    return ListTile(
      // onTap: onPress,
      leading: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          color: iconColor.withOpacity(0.1),
        ),
        child: Icon(icon, color: textColor??iconColor),
      ),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge?.apply(color: textColor)),
      trailing: endIcon? trailing??Container(
          width: 30.w,
          height: 30.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
            color: Colors.grey.withOpacity(0.1),
          ),
          child:  Icon(LineAwesomeIcons.angle_right, size: 18.0.sp, color: Colors.grey)) : null,
    );
  }
}
