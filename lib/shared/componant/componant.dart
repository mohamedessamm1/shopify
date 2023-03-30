import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//================================================================================================================
Widget defaultFormField(
        {Color? mycolor,
        String? Function(String?)? onChange,
        String? Function(String?)? onSubmit,
        String? Function(String?)? validate,
        required TextEditingController controller,
        required TextInputType type,
        required String label,
        required IconData prefix,
        IconData? suffix,
        Function()? suffixTab,
        bool isPassword = false,
        bool isenable = true,
        double fontsize = 20,
        double bordercircular = 0}) =>
    TextFormField(
      enabled: isenable,
      controller: controller,
      keyboardType: type,
      validator: validate,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      obscureText: isPassword,
      style: const TextStyle(fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        labelStyle: TextStyle(fontSize: fontsize, color: mycolor),
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: (suffix != null)
            ? InkWell(
                onTap: suffixTab,
                radius: 0.0,
                highlightColor: Colors.transparent,
                child: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(bordercircular))),
      ),
    );
//================================================================================================================

Widget defaultButton({
  double width = double.infinity,
  double height = 45.0,
  double bordercircular = 5,
  Color backgroundColor = Colors.deepPurple,
  required Function() function,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(bordercircular),
          color: backgroundColor),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );

//================================================================================================================
enum ShowToastState { SUCCESS, ERROR, WARNING }

Color? color;


showtoast({required text, required ShowToastState state}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.blueGrey,
      textColor: Colors.white,
      fontSize: 20.0);

  Color? toastcolor(ShowToastState state) {
    switch (state) {
      case ShowToastState.SUCCESS:
        color = Colors.green;
        break;
      case ShowToastState.ERROR:
        color = Colors.red;
        break;
      case ShowToastState.WARNING:
        color = Colors.amberAccent;
    }
    return color;
  }
}
//================================================================================================================
