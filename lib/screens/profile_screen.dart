import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shop_app/cubits/login_cubit/login_cubit.dart';
import 'package:shop_app/screens/shop_app_screen.dart';

import '../constants.dart';
import '../widgets/profile_menu_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return BlocConsumer<LoginCubit,LoginState>(
      listener: (context, state) {

        },
      builder: (context,state) {
        if (state is LoginSuccess)
        {
          var user=state.loginModel;
          var drowpDownvalue;
          var switchValue =false;
          return Scaffold(

            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              // leading: IconButton(onPressed: () {}, icon: const Icon(LineAwesomeIcons.angle_left)),
              title: Text("Profile",style: customTextStyle(fontWeight: FontWeight.w600,fontSize: 22,color: kPrimaryColor),),
              // actions: [IconButton(onPressed: () {}, icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon,color: isDark ?Colors.white:Colors.black,))],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [

                    /// -- IMAGE
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(

                            borderRadius: BorderRadius.circular(200), child: CachedNetworkImage(imageUrl: user.data!.image!,width: 140,height: 140,fit: BoxFit.cover,)),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: kPrimaryColor),
                            child: const Icon(
                              LineAwesomeIcons.alternate_pencil,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(user.data!.name!, style: Theme.of(context).textTheme.headline4),
                    //Text(user.data!.email!, style: Theme.of(context).textTheme.bodyText2),
                    const SizedBox(height: 20),

                    /// -- BUTTON
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor, side: BorderSide.none, shape: const StadiumBorder()),
                        child: const Text("edit profile",),
                      ),
                    ),


                    /// -- MENU///
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: ExpansionTile(
                        trailing: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.grey.withOpacity(0.1),
                            ),
                            child: const Icon(LineAwesomeIcons.angle_down, size: 18.0, color: Colors.grey)),
                        tilePadding: EdgeInsets.all(0),
                        title: ProfileMenuWidget(title: "Information", icon: LineAwesomeIcons.info,endIcon: false, onPress: () {

                        }),
                        children: [
                          ProfileMenuWidget(title: user.data!.email!, icon: Icons.email,endIcon: false,textColor: Colors.grey, onPress: () {

                          }),
                          ProfileMenuWidget(title: user.data!.phone!, icon: Icons.phone,endIcon: false,textColor: Colors.grey, onPress: () {

                          }),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: ExpansionTile(
                              trailing: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.grey.withOpacity(0.1),
                                  ),
                                  child: const Icon(LineAwesomeIcons.angle_down, size: 18.0, color: Colors.grey)),
                              tilePadding: EdgeInsets.all(0),
                              title: ProfileMenuWidget(title: "Addresses", icon: Icons.location_on_outlined,endIcon: false, onPress: () {

                              }),
                              children: [
                                ProfileMenuWidget(title: user.data!.email!, icon: Icons.email,endIcon: false,textColor: Colors.grey, onPress: () {

                                }),
                                ProfileMenuWidget(title: user.data!.phone!, icon: Icons.phone,endIcon: false,textColor: Colors.grey, onPress: () {

                                }),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: ExpansionTile(
                        trailing: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.grey.withOpacity(0.1),
                            ),
                            child: const Icon(LineAwesomeIcons.angle_down, size: 18.0, color: Colors.grey)),
                        tilePadding: EdgeInsets.all(0),
                        title: ProfileMenuWidget(title: "Settings", icon: LineAwesomeIcons.info,endIcon: false, onPress: () {

                        }),
                        children: [
                          ProfileMenuWidget(title: 'Mode', icon:LineAwesomeIcons.sun  ,endIcon: true,textColor: Colors.grey, onPress: () {

                          },
                            trailing: Switch(
                              activeColor: kPrimaryColor,
                                inactiveThumbColor: Colors.grey,
                                value: switchValue,
                                onChanged: (value) {

                                },
                            ),
                          ),
                          ProfileMenuWidget(title: 'Change language', icon:LineAwesomeIcons.language  ,endIcon: true,textColor: Colors.grey, onPress: () {

                          },
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
                    ProfileMenuWidget(
                        title: "Logout",
                        icon: LineAwesomeIcons.alternate_sign_out,
                        textColor: Colors.red,
                        endIcon: false,
                        onPress: () {
                          signOut(context);
                        }),
                  ],
                ),
              ),
            ),
          );
        }
       return SizedBox();
      }
    );
  }
}