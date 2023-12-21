
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_app/cache_helper/shared_preferences.dart';
import 'package:shop_app/cubits/login_cubit/login_cubit.dart';
import 'package:shop_app/cubits/user_cubit/user_cubit.dart';
import 'package:shop_app/screens/shop_app_screen.dart';
import 'package:shop_app/screens/register_screen.dart';

import '../constants.dart';
import '../widgets/custom_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
   final GlobalKey<FormState> formKey=GlobalKey();

    String? email;

    String? password;

    return  BlocProvider(
  create: (context) => LoginCubit(),
  child: BlocConsumer<LoginCubit,LoginState>(
      builder: (context, state) {
        var isLoading=LoginCubit.get(context).isLoading;

        return Scaffold(
          body:
          SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding:  EdgeInsets.all(12.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 150.h,
                    ),
                    //Center(child: Lottie.asset('assets/images/login_purple.json',height:200 ,width: 200,frameRate: FrameRate(60),fit: BoxFit.fill,)),

                    Text('LOGIN',style: customTextStyle(fontSize: 36.sp,color: kPrimaryColor,fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Login now to explore our products',style: customTextStyle(fontSize: 18.sp,color: Colors.grey,height: 0,letterSpacing: -0.32)),

                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextForm(onChanged:(value) {
                      email=value;
                    }, isPassword: false,hintText: 'Enter your email',labelText: 'Email',prefixIcon: Icons.email_outlined),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextForm(
                        onChanged: (value) {
                          password=value;
                        },
                        isPassword: true,hintText: 'Enter your password',labelText: 'Password',prefixIcon: Icons.lock),


                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: CustomButton(
                        text: isLoading ? null : 'LOGIN',
                        onPressed: ()
                        async{



                          if(formKey.currentState!.validate())
                          {

                            await LoginCubit.get(context).loginUser(email: email!, password: password!);
                            // successMethod(context,msg: 'login success');


                          }

                        },

                      ),
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("don't have an account ? ",style: customTextStyle(fontSize: 16.sp,color: Colors.grey ,fontWeight: FontWeight.w400,
                          height: 0,
                          letterSpacing: -0.32, )),
                        TextButton(onPressed: ()
                        {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => const RegisterScreen(),));
                        }, child: Text('Register',style: customTextStyle(fontSize: 18.sp,color: kPrimaryColor,fontWeight: FontWeight.w400,
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
      listener: (context, state) async{
        if (state is LoginSuccess)
        {
        ShowToastMessage(
          msg:state.loginModel.message!,
          color: Colors.green,
        );

       await CacheHelper.saveData(key: kToken,value:state.loginModel.data!.token).then((value)async{
          if(value)
          {
            token= await CacheHelper.getData(key: kToken);
            UserCubit.get(context).getUserProfile();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ShopAppScreen(),));

          }
        });

        }
        if (state is LoginFailed)
        {
          ShowToastMessage(
            msg:state.loginModel.message!,
            color: Colors.red,
          );
        }
      },),
);
  }

  void successMethod(BuildContext context, {required String msg}) {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(milliseconds:1500 ), () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegisterScreen(),));
            // Navigator.of(context).pop(true);
          });
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)
            ),
            icon:Lottie.asset('assets/images/done.json',width: 150,height: 150) ,
            title: Text(msg) ,
            titleTextStyle:customTextStyle(fontSize: 36,color: Colors.green),
            // backgroundColor: Colors.transparent,

          );

        });
  }
}