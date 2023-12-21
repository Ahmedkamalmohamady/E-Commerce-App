import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shop_app/cubits/user_cubit/user_cubit.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/screens/shop_app_screen.dart';
import 'package:shop_app/screens/update_profile_screen.dart';

import '../constants.dart';
import '../widgets/profile_menu_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var switchValue=false;
    return BlocBuilder<UserCubit,UserState>(
    builder: (context, state) {
      LoginModel? user = UserCubit
          .get(context)
          .userInfo;
      return Scaffold(

          appBar: AppBar(
            actions: [
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfileScreen(user: user!),));


              }, child:  Row(
                children: [
                  Text('Edit',style: customTextStyle(
                    fontSize: 16.sp,fontWeight: FontWeight.w600
                  ),),
                  Icon(
                    LineAwesomeIcons.alternate_pencil,
                    color: kPrimaryColor,
                    size: 20.sp,
                  ),
                ],
              ))
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
            // leading: IconButton(onPressed: () {}, icon: const Icon(LineAwesomeIcons.angle_left)),
            title: Text("Profile",style: customTextStyle(fontWeight: FontWeight.w600,fontSize: 22.sp,color: kPrimaryColor),),
            // actions: [IconButton(onPressed: () {}, icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon,color: isDark ?Colors.white:Colors.black,))],
          ),
          body: user!=null? SingleChildScrollView(
            child: Container(
              padding:  EdgeInsets.all(8.0.w),
              child: Column(
                children: [

                  /// -- IMAGE
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipRRect(

                          borderRadius: BorderRadius.circular(200.r), child: CachedNetworkImage(imageUrl: user.data!.image!,width: 140.w,height: 140.w,fit: BoxFit.cover,errorWidget: (context, url, error) {
                        return const Column(
                          children: [
                            Icon(Icons.error_outline,size: 50),
                            Text('Invalid image',)
                          ],
                        );
                      },)),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.r), color: kPrimaryColor),
                          child:  Icon(
                            LineAwesomeIcons.alternate_pencil,
                            color: Colors.black,
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(user.data!.name!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 24.sp
                  )),
                  //Text(user.data!.email!, style: Theme.of(context).textTheme.bodyText2),
                  const SizedBox(height: 20),

                  /// -- BUTTON
                  // SizedBox(
                  //   width: 200.w,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //         backgroundColor: kPrimaryColor, side: BorderSide.none, shape: const StadiumBorder()),
                  //     child: const Text("edit profile",),
                  //   ),
                  // ),


                  /// -- MENU///
                  Padding(
                    padding:  EdgeInsets.only(right: 10.0.w),
                    child: ExpansionTile(
                      trailing: Container(
                          width: 30.w,
                          height: 30.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          child:  Icon(LineAwesomeIcons.angle_down, size: 18.0.sp, color: Colors.grey)),
                      tilePadding: const EdgeInsets.all(0),
                      title: const ProfileMenuWidget(title: "Information", icon: LineAwesomeIcons.info,endIcon: false,),
                      children: [
                        ProfileMenuWidget(title: user.data!.email!, icon: Icons.email,endIcon: false,textColor: Colors.grey,

                        ),
                        ProfileMenuWidget(title: user.data!.phone!, icon: Icons.phone,endIcon: false,textColor: Colors.grey,

                        ),
                        Padding(
                          padding:  EdgeInsets.only(right: 10.0.w),
                          child: ExpansionTile(
                            trailing: Container(
                                width: 30.w,
                                height: 30.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.r),
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                                child:  Icon(LineAwesomeIcons.angle_down, size: 18.0.sp, color: Colors.grey)),
                            tilePadding: const EdgeInsets.all(0),
                            title: const ProfileMenuWidget(title: "Addresses", icon: Icons.location_on_outlined,endIcon: false,

                            ),
                            children: [
                              ProfileMenuWidget(title: user.data!.email!, icon: Icons.email,endIcon: false,textColor: Colors.grey,

                              ),
                              ProfileMenuWidget(title: user.data!.phone!, icon: Icons.phone,endIcon: false,textColor: Colors.grey,
                                //     onPress: () {
                                //
                                // }
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding:  EdgeInsets.only(right: 10.0.h),
                    child: ExpansionTile(
                      trailing: Container(
                          width: 30.w,
                          height: 30.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          child:  Icon(LineAwesomeIcons.angle_down, size: 18.0.sp, color: Colors.grey)),
                      tilePadding: const EdgeInsets.all(0),
                      title: const ProfileMenuWidget(title: "Settings", icon: LineAwesomeIcons.cog,endIcon: false,

                      ),
                      children: [
                        ProfileMenuWidget(title: 'Mode', icon:LineAwesomeIcons.sun  ,endIcon: true,textColor: Colors.grey,
                          //   onPress: () {
                          //
                          // },
                          trailing: Switch(
                            activeColor: kPrimaryColor,
                            inactiveThumbColor: Colors.grey,
                            value: switchValue=false,
                            onChanged: (value) {

                            },
                          ),
                        ),
                        ProfileMenuWidget(title: 'Change language', icon:LineAwesomeIcons.language  ,endIcon: true,textColor: Colors.grey,
                          trailing: Switch(
                            activeColor: kPrimaryColor,
                            inactiveThumbColor: Colors.grey,
                            value: switchValue,
                            onChanged: (value) {

                            },
                          ),
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      UserCubit.get(context).userInfo=null;
                      signOut(context);
                    },
                    child: const ProfileMenuWidget(
                      title: "Logout",
                      icon: LineAwesomeIcons.alternate_sign_out,
                      textColor: Colors.red,
                      endIcon: false,
                    ),
                  ),
                ],
              ),
            ),
          )
              :const LinearProgressIndicator(color: kPrimaryColor,));
    },
);
}
}