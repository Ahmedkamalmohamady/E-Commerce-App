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
          return Scaffold(

            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(onPressed: () {}, icon: const Icon(LineAwesomeIcons.angle_left)),
              title: Text("Profile",style: customTextStyle(fontWeight: FontWeight.w600,fontSize: 22,color: kPrimaryColor),),
              actions: [IconButton(onPressed: () {}, icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon,color: isDark ?Colors.white:Colors.black,))],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [

                    /// -- IMAGE
                    Stack(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100), child: CachedNetworkImage(imageUrl: user.data!.image!)),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 35,
                            height: 35,
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
                    Text(user.data!.email!, style: Theme.of(context).textTheme.bodyText2),
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
                    const SizedBox(height: 30),
                    const Divider(),
                    const SizedBox(height: 10),

                    /// -- MENU
                    ProfileMenuWidget(title: "Settings", icon: LineAwesomeIcons.cog, onPress: () {}),
                    ProfileMenuWidget(title: "Billing Details", icon: LineAwesomeIcons.wallet, onPress: () {}),
                    ProfileMenuWidget(title: "User Management", icon: LineAwesomeIcons.user_check, onPress: () {}),
                    const Divider(),
                    const SizedBox(height: 10),
                    ProfileMenuWidget(title: "Information", icon: LineAwesomeIcons.info, onPress: () {}),
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