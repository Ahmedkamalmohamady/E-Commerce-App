
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/screens/login_screen.dart';
import 'package:shop_app/widgets/custom_text_form_field.dart';

import '../constants.dart';

import '../widgets/custom_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var isLoading= false;
  GlobalKey<FormState> formKey =GlobalKey();
  @override
  Widget build(BuildContext context) {
    double height =const MediaQueryData().size.height;

    double width =const MediaQueryData().size.width;
    String email='';
    String password='';
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
                      email =value;
                    }
                    ,isPassword: false,hintText: 'Enter your user name',labelText: 'UserName',prefixIcon: Icons.person),
                const SizedBox(
                  height: 10,
                ),
                CustomTextForm(
                  type: TextInputType.phone,
                    onChanged: (value) {
                      email =value;
                    }
                    ,isPassword: false,hintText: 'Enter your phone number',labelText: 'Phone',prefixIcon: Icons.phone),  const SizedBox(
                  height: 10,
                ),
                CustomTextForm(
                    onChanged: (value) {
                      email =value;
                    }
                    ,isPassword: false,hintText: 'Enter your email',labelText: 'Email',prefixIcon: Icons.email_outlined),
                const SizedBox(
                  height: 10,
                ),
                CustomTextForm(
                    onChanged: (value) {
                      password =value;
                    },
                    isPassword: true,hintText: 'Enter your password',labelText: 'Password',prefixIcon: Icons.lock),

                const SizedBox(
                  height: 10,
                ),
                CustomButton(

                  text: isLoading ? null : 'Register',
                  onPressed: isLoading ? null : () async {
                    //   if (formKey.currentState!.validate()){
                    //   // {
                    //   //   setState(() {
                    //   //     isLoading = true; // Show loading state
                    //   //   });
                    //   //   try {
                    //   //     await registerAccount(email, password);
                    //   //
                    //   //     // Registration successful, show toast or snackbar
                    //   //     ShowToastMessage("Registration successful",Colors.green);
                    //   //     Navigator.pushNamed(context, 'loginScreen');
                    //   //
                    //   //
                    //   //     setState(() {
                    //   //       isLoading = false; // Disable loading state
                    //   //     });
                    //   //   }on FirebaseAuthException catch (e) {
                    //   //     if(e.code=='weak-password')
                    //   //     {
                    //   //       ShowToastMessage('weak password',Colors.red);
                    //   //     }
                    //   //     else if (e.code=='email-already-in-use')
                    //   //     {
                    //   //       ShowToastMessage('email already exist',Colors.red);
                    //   //
                    //   //     }
                    //   //     else{
                    //   //       ShowToastMessage(e.code.toString(),Colors.black);
                    //   //     }
                    //   //     setState(() {
                    //   //       isLoading = false; // Disable loading state
                    //   //     });
                    //   //   }
                    //   // }
                    //
                    // },
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
  }




}