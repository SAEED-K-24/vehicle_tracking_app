import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehicle_tracking/reuseable/fail_dialog.dart';

void onHorizontalLoading(
    BuildContext context, String text, Color? color, bool? dissmiss) {
  showDialog(
    context: context,
    barrierDismissible: dissmiss ?? false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        contentPadding: const EdgeInsets.all(0.0),
        content: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Row(
            children: [
              const SizedBox(width: 16.0),
              CircularProgressIndicator(
                backgroundColor: const Color(0xffD6D6D6),
                strokeWidth: 4,
                valueColor: color != null
                    ? AlwaysStoppedAnimation<Color>(color)
                    : const AlwaysStoppedAnimation<Color>(Colors.blueGrey),
              ),
              const SizedBox(width: 16.0),
              Text(
                text,
                style: GoogleFonts.cairo(fontSize: 16.0),
              ),
            ],
          ),
        ),
      );
    },
  );
}

showMyDialog(
    {required BuildContext context,
      String? title,
      String? description,
      String? message,
      String? buttonText}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return FailDialog(
          title: title,
          description: description,
          message: message,
          buttonText: buttonText,
        );
      });
}