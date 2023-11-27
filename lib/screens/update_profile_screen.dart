import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shop_app/cubits/user_cubit/user_cubit.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/widgets/custom_widgets.dart';

import '../constants.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key, required this.user}) : super(key: key);
  final LoginModel user;


  @override
  Widget build(BuildContext context) {
    var formKey=GlobalKey<FormState>();
    final TextEditingController nameController=TextEditingController(text:user.data!.name );
    final TextEditingController emailController=TextEditingController(text:user.data!.email );
    final TextEditingController phoneController=TextEditingController(text:user.data!.phone );
    final TextEditingController passwordController=TextEditingController();
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
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const CircleAvatar()),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100), color: kPrimaryColor),
                      child: InkWell(
                        onTap: () async {
                          XFile? image= await ImagePicker().pickImage(source: ImageSource.gallery,);
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
                      nameController.text==user.data!.name&&
                      emailController.text==user.data!.email&&
                      phoneController.text==user.data!.phone&&
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
                              image:user.data!.image,
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