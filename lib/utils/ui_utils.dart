import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practical/constants/color_constants.dart';


class UiUtils {


 

  static GetBar errorSnackBar({String title = 'Error', String? message}) {
    Get.log("[$title] $message", isError: true);
    return GetBar(
      // titleText: Text(title.tr,
      //     style: Get.textTheme.headline6!
      //         .merge(TextStyle(color: Get.theme.primaryColor))),
      messageText: Text(
        message!,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 14.0,
        ),
      ),
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(20),
      backgroundColor: Colors.red.shade50,
      icon: Wrap(
        children: [
          Card(
            elevation: 2.0,
            margin: EdgeInsets.all(8.0),
            color: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child:
                  Icon(Icons.warning_rounded, size: 32.0, color: Colors.white),
            ),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
      borderWidth: 1.0,
      borderRadius: 12.0,
      borderColor: ColorConstants.colorPrimary,
      duration: Duration(seconds: 5),
    );
  }

 
}
