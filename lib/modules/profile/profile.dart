import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practical/constants/preferences_constants.dart';
import 'package:practical/constants/size_constants.dart';
import 'package:practical/modules/login/screens/auth_screen.dart.dart';
import 'package:practical/routes/app_routes.dart';
import 'package:practical/utils/ui_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile_Screen extends StatefulWidget {
  const Profile_Screen({Key? key}) : super(key: key);

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences _sharedPreferences;
  RxString User_Name = ''.obs;
  RxString User_Email = ''.obs;
  @override
  void initState() {
    _prefs.then((SharedPreferences sharedPreferences) {
      _sharedPreferences = sharedPreferences;

      User_Email.value =
          _sharedPreferences.getString(PreferencesConstants.EMAIL)!;
      User_Name.value =
          _sharedPreferences.getString(PreferencesConstants.USERNAME)!;
      super.initState();
    }).catchError((err) {
      //   UiUtils.errorSnackBar(message: '$err').show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        actions: [
          PopupMenuButton(
            onSelected: (selectedValue) {
              if (selectedValue == 1) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Are you sure?"),
                        content: const Text(
                            "Are you sure to logout from application?"),
                        actions: [
                          ElevatedButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                await preferences
                                    .remove(PreferencesConstants.ISLOGIN);
                                await preferences
                                    .remove(PreferencesConstants.USERID);
                                await preferences
                                    .remove(PreferencesConstants.EMAIL);
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            AuthScreen()));
                              },
                              child: const Text("OK")),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Cancel"))
                        ],
                      );
                    });
              }
            },
            icon: const Icon(Icons.settings),
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text('Logout'),
                value: 1,
              )
            ],
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          const Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  'https://i.picsum.photos/id/866/200/300.jpg?hmac=rcadCENKh4rD6MAp6V_ma-AyWv641M4iiOpe1RyFHeI'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(() {
            return Column(
              children: [
                Text(
                  User_Name.value,
                  style: const TextStyle(
                      fontSize: SizeConstants.SIZE_16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  User_Email.value,
                  style: const TextStyle(fontSize: SizeConstants.SIZE_14),
                )
              ],
            );
          }),
        ],
      ),
    );
  }
}
