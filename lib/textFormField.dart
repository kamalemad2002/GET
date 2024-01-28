import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';



class textFormField extends StatelessWidget {
  final bool? hidden;
  textFormField({super.key,this.hintText,this.onChanged,this.labelText,this.obscureText , required this.hidden});
String? email,password;
String? hintText;
 String? labelText;
final bool? obscureText;
Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return
    TextFormField(
      obscureText: hidden!
      ,
      onChanged: onChanged,
      validator: (data) {
        if (data!.isEmpty)
          return 'Required';
        // return 'Required';
      },
    decoration: InputDecoration(
      suffixIcon: hidden! ? IconButton(
        icon: Icon(
          Icons.visibility_off,
        ),
        onPressed: (){
          print("For secuirity, password cannot be visible");
          AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.rightSlide,
            title: '',
            desc:
            'For secuirity, password cannot be visible',
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
          ).show();

        },
        // onPressed: setState(() {
        //   hi = !_obscureText;
        // });,
      ): IconButton(
        icon: Icon(
          Icons.email,
        ),
        onPressed: (){

        },
      ),

    labelText: labelText,
    hintText: hintText,
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(40))),
    );
  }
}
