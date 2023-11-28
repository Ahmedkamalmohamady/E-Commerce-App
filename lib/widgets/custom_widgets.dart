import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../constants.dart';

class CustomTextForm extends StatefulWidget {
  CustomTextForm({super.key,required this.isPassword ,this.controller,this.onChanged, this.hintText,this.labelText,this.prefixIcon,this.radius=3,this.type=TextInputType.text});
  String? hintText;
  String? labelText;
  IconData? prefixIcon;
  bool isPassword;
  double radius;
  TextInputType type=TextInputType.none;
  TextEditingController? controller;
  Function (String)? onChanged;

  @override
  State<CustomTextForm> createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  bool showPassword=false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.type,
      validator: (value) {
        if (value!.isEmpty)
        {
          return 'this filed musn\'t be empty';
        }
      },
      onChanged: widget.onChanged,
      obscureText: showPassword,

      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),

        ),
        hintText: widget.hintText,
        label: Text(widget.labelText!),
        labelStyle: const TextStyle(color: Colors.grey,
            fontSize: 18

        ),

        prefixIcon: Icon(widget.prefixIcon,color: Colors.grey,),
        suffixIcon: widget.isPassword?IconButton(
            onPressed: (){
              setState(() {
                showPassword=!showPassword;
              });
            }, icon:showPassword?
        const Icon(CupertinoIcons.eye_slash,color:Colors.grey,):const Icon(CupertinoIcons.eye,color:Colors.grey,)):
        const SizedBox(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: const BorderSide(
            color: kPrimaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),

      ),
    );
  }
}
class CustomButton extends StatefulWidget {
  const CustomButton({
    this.text,
    this.onPressed,
    this.radius=10.0,
    this.width=double.maxFinite,
    this.height=50,
    Key? key, this.textStyle,
  }) : super(key: key);

  final String? text;
  final VoidCallback? onPressed;
  final  double radius;
  final double width;
  final double height;
  final TextStyle? textStyle;
  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(kPrimaryColor),
        fixedSize: MaterialStateProperty.all(Size(widget.width,widget.height)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.radius)),
        ),
      ),
      onPressed: widget.onPressed,
      child: widget.text != null
          ? Text(
        widget.text!,
        style: widget.textStyle??TextStyle(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black54
              : Colors.white,
          fontWeight: FontWeight.w600,
          height: 0,
          letterSpacing: -0.32,
          fontSize: 16,
        ),
      )
          : const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }
}

void ShowToastMessage({required String msg, Color? color}) {
  Fluttertoast.showToast(

    fontSize: 18,
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: color,
  );
}


// class CustomShape extends CustomPainter {
//   final Color bgColor;
//
//   CustomShape(this.bgColor);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     var paint = Paint()..color = bgColor;
//
//     var path = Path();
//     path.lineTo(-5, 0);
//     path.lineTo(0, 10);
//     path.lineTo(5, 0);
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }
//
// class SendMessage extends StatelessWidget {
//   const SendMessage({Key? key, required this.message}) : super(key: key);
//   final String message;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(right: 18.0, left: 50, top: 15, bottom: 5),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: <Widget>[
//           SizedBox(height: 30),
//           Flexible(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Flexible(
//                     child: Container(
//                       padding: EdgeInsets.all(14),
//                       decoration: BoxDecoration(
//                         color: kPrimaryColor,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(18),
//                           bottomLeft: Radius.circular(18),
//                           bottomRight: Radius.circular(18),
//                         ),
//                       ),
//                       child: Text(
//                         message,
//                         style: TextStyle(color: Colors.white, fontSize: 14,fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                   CustomPaint(painter: CustomShape(kPrimaryColor)),
//                 ],
//               )),
//         ],
//       ),
//     );
//   }
//
// }
//
// class ReceiveMessage extends StatelessWidget {
//   const ReceiveMessage({Key? key, required this.message}) : super(key: key);
//   final String message;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(right: 18.0, left: 20, top: 10, bottom: 5),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: <Widget>[
//           SizedBox(height: 30),
//           Flexible(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Transform(
//                     alignment: Alignment.center,
//                     transform: Matrix4.rotationY(3.14),
//                     child: CustomPaint(
//                       painter: CustomShape(Colors.grey[300]!),
//                     ),
//                   ),
//                   Flexible(
//                     child: Container(
//                       padding: EdgeInsets.all(14),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[300],
//                         borderRadius: BorderRadius.only(
//                           topRight: Radius.circular(18),
//                           bottomLeft: Radius.circular(18),
//                           bottomRight: Radius.circular(18),
//                         ),
//                       ),
//                       child: Text(
//                         message,
//                         style: TextStyle(color: Colors.black, fontSize: 14),
//                       ),
//                     ),
//                   ),
//                 ],
//               )),
//         ],
//       ),
//     );
//   }
//
// }