
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/cubits/user_cubit/user_cubit.dart';
import 'package:shop_app/screens/login_screen.dart';
import 'package:shop_app/widgets/custom_text_form_field.dart';

import '../constants.dart';

import '../widgets/custom_widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey =GlobalKey();
    double height =const MediaQueryData().size.height;
    double width =const MediaQueryData().size.width;
    final TextEditingController nameController=TextEditingController();
    final TextEditingController emailController=TextEditingController();
    final TextEditingController phoneController=TextEditingController();
    final TextEditingController passwordController=TextEditingController();
    return BlocConsumer<UserCubit, UserState>(
  listener: (context, state) {
    if(state is RegisterUserSuccess)
    {
      ShowToastMessage(msg: state.message);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));


    }
    if(state is RegisterUserFailed)
    {
      ShowToastMessage(msg: state.errorMessage);
    }

  },
  builder: (context, state) {
    return Scaffold(
      body:
      SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: width+180,
                ),
                //Center(child: Lottie.asset('assets/images/login_purple.json',height:200 ,width: 200,frameRate: FrameRate(60),fit: BoxFit.fill,)),

                Text('Create an account',style: customTextStyle(fontSize: 32,color: kPrimaryColor,fontWeight: FontWeight.w600,height: 0.05,
                  letterSpacing: -1.60,)),
                const SizedBox(
                  height: 10,
                ),
                Text("Let’s create your account",style: customTextStyle(fontSize: 16,color: Colors.grey,height: 0,
                  letterSpacing: -0.32,)),

                const SizedBox(
                  height: 10,
                ),
                CustomTextForm(
                    onChanged: (value) {
                      nameController.text =value;
                    }
                    ,isPassword: false,hintText: 'Enter your user name',labelText: 'UserName',prefixIcon: Icons.person),
                const SizedBox(
                  height: 10,
                ),
                CustomTextForm(
                  type: TextInputType.phone,
                    onChanged: (value) {
                    phoneController.text=value;
                    }
                    ,isPassword: false,hintText: 'Enter your phone number',labelText: 'Phone',prefixIcon: Icons.phone),  const SizedBox(
                  height: 10,
                ),
                CustomTextForm(
                    onChanged: (value) {
                      emailController.text =value;
                    }
                    ,isPassword: false,hintText: 'Enter your email',labelText: 'Email',prefixIcon: Icons.email_outlined),
                const SizedBox(
                  height: 10,
                ),
                CustomTextForm(
                    onChanged: (value) {
                      passwordController.text =value;
                    },
                    isPassword: true,hintText: 'Enter your password',labelText: 'Password',prefixIcon: Icons.lock),

                const SizedBox(
                  height: 10,
                ),
                CustomButton(

                  text: UserCubit.get(context).isLoading ? null : 'Register',
                  onPressed: UserCubit.get(context).isLoading ? null : () async {
                  if(formKey.currentState!.validate())
                  {
                    UserCubit.get(context).registerUser(
                      name: nameController.text,
                      password: passwordController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                    );

                  }
                  }
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text("Already have an account ? ",style: customTextStyle(fontSize: 16,color: Colors.grey,fontWeight: FontWeight.w400,
                       height: 0,
                       letterSpacing: -0.32,)),
                    TextButton(onPressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                    }, child:  Text('login',style: customTextStyle(fontSize: 18,color: kPrimaryColor,fontWeight: FontWeight.w400,
                    height: 0,
                        letterSpacing: -0.32,decoration: TextDecoration.underline),))
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  },
);
  }
}