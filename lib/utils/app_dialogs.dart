import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:practical/constants/color_constants.dart';
import 'package:practical/constants/common_constants.dart';
import 'package:practical/constants/size_constants.dart';


class AppDialogs {


  static Future<void> showProgressDialog(
      {required BuildContext context,
      String msg = 'Please wait..',
      bool isDismissible = false}) {
    return showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (ctx) => Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: 74,
            width: 208,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorConstants.colorCanvas,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 18.0,
            ),
            child: Container(
              child: Row(
                children: [
                  SpinKitChasingDots(
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: index.isEven
                              ? ColorConstants.colorPrimary
                              : ColorConstants.colorAccent,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Material(
                    color: ColorConstants.colorCanvas,
                    child: FittedBox(
                      child: Text(
                        msg,
                        style: const TextStyle(
                          fontSize:SizeConstants.SIZE_14,
                          fontFamily: CommonConstants.FONT_FAMILY_REGULAR,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> showErrorDialog(
      {required BuildContext context,
      required String errorMsg,
      required Function onOkBtnClickListener}) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'An error occurred!',
          style: TextStyle(
            color: Colors.black,
            fontFamily: CommonConstants.FONT_FAMILY_REGULAR,
          ),
        ),
        content: Text(errorMsg),
        actions: [
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  return Theme.of(context).primaryColor;
                },
              ),
            ),
            onPressed: () => onOkBtnClickListener(),
            child: const Text(
              'Okay',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
