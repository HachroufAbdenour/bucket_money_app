import 'package:flutter/material.dart';
import 'package:money_app/shared/constants/app_values.dart';
import 'package:money_app/shared/styles/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  final IconData prefixIcon;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final TextInputType inputType;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.name,
    required this.prefixIcon,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    required this.inputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: TextField(
          enabled: true,
          controller: controller,
          textCapitalization: textCapitalization,
          maxLength: 32,
          maxLines: 1,
          obscureText: obscureText,
          keyboardType: inputType,
          textAlign: TextAlign.start,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(prefixIcon),
            isDense: true,
            labelText: name,
            counterText: "",
            labelStyle: const TextStyle(color: Colors.white),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ),
    );
  }
}






Widget MyTextField({
  required TextEditingController controller,
  bool isObscure = false,
  bool readOnly = false,
  Widget? suffixIcon,
  Widget? prefixIcon,
  String? hintText,
   TextStyle? hintStyle,
  // int? maxLines,
  String? Function(String?)? validator,
  TextInputType? keyboardType,
}) {
  return Container(
    padding: prefixIcon != null
        ? const EdgeInsets.only(left: 0, right: 10)
        : const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      color: greyColor.withOpacity(.2),
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextFormField(
      controller: controller,
      cursorColor: blackColor,
      obscureText: isObscure,
      //maxLines: maxLines,
      readOnly: readOnly,
      validator: validator,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.disabled,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintText,
                hintStyle: hintStyle ?? TextStyle(fontSize: 14, color: Colors.grey), // Apply default style if none provided

        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
    ),
  );
}


Widget MyFilledButton({
  required Widget child,
  required VoidCallback onPressed,
  Color color =AppColors.primary,
}) {
  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(color),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      elevation: MaterialStateProperty.all(0.0),
    ),
    onPressed: onPressed,
    child: child,
  );
}


class CustomText extends StatelessWidget {
  const CustomText(this.text,{super.key,  this.fontName = 'Raleway', this.color = onBgTextColor,  this.fontSize ,  this.textAlign = TextAlign.start , this.fontWeight = FontWeight.normal,this.textOverflow = TextOverflow.visible,this.height});
  final String text;
  final Color color;
  final double? fontSize ;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final TextOverflow textOverflow;
  final double? height; 
  final String? fontName;
  @override
  Widget build(BuildContext context) {
    return  Text(text,style: TextStyle(height: height, fontSize:  fontSize ?? 14,color: color,fontWeight: fontWeight,fontFamily: fontName),textAlign: textAlign,overflow: textOverflow,maxLines: null);
  }
}