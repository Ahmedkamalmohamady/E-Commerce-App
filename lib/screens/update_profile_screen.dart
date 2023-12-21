import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shop_app/cubits/user_cubit/user_cubit.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/widgets/custom_widgets.dart';

import '../constants.dart';

class UpdateProfileScreen extends StatefulWidget {
   const UpdateProfileScreen({Key? key, required this.user}) : super(key: key);
  final LoginModel user;

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey=GlobalKey();
    final  nameController=TextEditingController(text:widget.user.data!.name );
    final  emailController=TextEditingController(text:widget.user.data!.email );
    final phoneController=TextEditingController(text:widget.user.data!.phone );
    final  passwordController=TextEditingController();
    return BlocProvider(
  create: (context) => UserCubit(),
  child: BlocBuilder<UserCubit, UserState>(
  builder: (context, state) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('EditProfile',style: TextStyle(color: kPrimaryColor)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // -- IMAGE with ICON
              Stack(
                children: [
                  SizedBox(
                    width: 120.w,
                    height: 120.w,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.r),
                        child: const CircleAvatar()),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35.w,
                      height: 35.w,
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100.r), color: kPrimaryColor),
                      child: InkWell(
                        onTap: () async {
                         // XFile? image= await ImagePicker().pickImage(source: ImageSource.gallery,);
                        },
                          child: const Icon(LineAwesomeIcons.camera, color: Colors.black, size: 20)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              // -- Form Fields
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextForm(controller:nameController ,isPassword: false,labelText: 'Name',type: TextInputType.name,prefixIcon: Icons.person,onChanged: (value) {
                      nameController.text=value;
                    },),
                    const SizedBox(height: 10,),
                    CustomTextForm(controller: emailController,isPassword: false,labelText: 'Email',type: TextInputType.emailAddress,prefixIcon: Icons.email,onChanged: (value) {
                      emailController.text=value;
                    },),
                    const SizedBox(height: 10,),
                    CustomTextForm(controller: phoneController,isPassword: false,labelText: 'Phone',type: TextInputType.phone,prefixIcon: Icons.phone,onChanged: (value) {phoneController.text=value;},),
                    const SizedBox(height: 10,),
                    CustomTextForm(controller: passwordController,isPassword: false,labelText: 'password',type: TextInputType.visiblePassword,prefixIcon: Icons.lock,onChanged: (value) {
                      passwordController.text=value;
                    },),
                    const SizedBox(height: 10,),
                    CustomButton(text: UserCubit.get(context).isLoading?null:'Update'.toUpperCase(),
                      onPressed: () {
                      if(
                      nameController.text==widget.user.data!.name&&
                      emailController.text==widget.user.data!.email&&
                      phoneController.text==widget.user.data!.phone&&
                      passwordController.text.isEmpty
                      )
                      {
                        ShowToastMessage(msg: 'please enter your changes',);
                      }
                      else{
                          UserCubit.get(context).updateUserProfile(
                              name:nameController.text,
                              email:emailController.text,
                              phone:phoneController.text,
                              password:passwordController.text,
                              image:widget.user.data!.image,
                            context: context
                          );
                          print('updated successflly ');
                        }
                      },)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  },
),
);
  }
}