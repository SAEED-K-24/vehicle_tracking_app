import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  const CustomTextFormFieldWidget({super.key,this.controller,this.label,this.validateMsg,this.obscureText = false});
  final TextEditingController? controller;
  final String? label;
  final String? validateMsg;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[600]!)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        label: Text(
          "$label",
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.black,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$validateMsg';
        }
        return null;
      },
    );
  }
}
