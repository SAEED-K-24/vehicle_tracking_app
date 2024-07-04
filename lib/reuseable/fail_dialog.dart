import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehicle_tracking/constant.dart';


class FailDialog extends StatelessWidget {
  String? title;
  String? description;
  String? message;
  String? buttonText;
  FailDialog({
    Key? key,
    this.title,
    this.description,
    this.message,
    this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Center(
                  child: Icon(
                    Icons.sentiment_dissatisfied_outlined,
                    size: 40,
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Center(
                  child: Text(
                      title != null ? title! : "خطأ!",
                      style: GoogleFonts.cairo(
                          fontWeight: FontWeight.w700, fontSize: 18.0))),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Center(
                  child: Text(
                    description != null
                        ? description!
                        : "حدث خطأ ما!!",
                    style: GoogleFonts.cairo(
                        fontWeight: FontWeight.w600, fontSize: 16.0),
                    maxLines: 4,
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Center(
                  child: Text(
                    message != null
                        ? message!
                        : "الرجاء حاول مرة أخرى",
                    style: GoogleFonts.cairo(
                        fontWeight: FontWeight.w500, fontSize: 15.0),
                    textAlign: TextAlign.center,
                    maxLines: 4,
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shadowColor: themeData.colorScheme.primary,
                      backgroundColor: PRIMARY_COLOR,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      buttonText != null
                          ? buttonText!
                          : "حاول مرة أخرى",
                      style: GoogleFonts.cairo(
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.4,
                          color: themeData.colorScheme.onPrimary),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
