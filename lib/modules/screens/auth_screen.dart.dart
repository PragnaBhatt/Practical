import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practical/common/AppLanguage.dart';
import 'package:practical/common/app_localizations.dart';
import 'package:practical/constants/color_constants.dart';
import 'package:practical/constants/preferences_constants.dart';
import 'package:practical/modules/controllers/common_parm_controller.dart';
import 'package:practical/modules/profile/profile.dart';
import 'package:practical/routes/app_routes.dart';
import 'package:practical/utils/ui_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthMode { Signup, Login }
RxString title = ''.obs;

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    var appLanguage = Provider.of<AppLanguage>(context, listen: true);
    print(
        "data11..... ${AppLocalizations.of(context)!.translate('Signin').toString()}");
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      backgroundColor: ColorConstants.colorBlack,
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(32, 31, 63, 255).withOpacity(0.2),
                    Color.fromRGBO(32, 31, 63, 255).withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0, 1],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: deviceSize.height,
                width: deviceSize.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        // margin: EdgeInsets.only(bottom: 20.0),
                        // padding: EdgeInsets.symmetric(
                        //     vertical: 8.0, horizontal: 94.0),
                        // transform: Matrix4.rotationZ(-8 * pi / 180)
                        //   ..translate(-10.0),
                        // // ..translate(-10.0),
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(20),
                        //   color: Colors.deepOrange.shade900,
                        //   boxShadow: [
                        //     BoxShadow(
                        //       blurRadius: 8,
                        //       color: Colors.black26,
                        //       offset: Offset(0, 2),
                        //     )
                        //   ],
                        // ),
                        child: Text(
                          AppLocalizations.of(context)!
                              .translate('Signin')
                              .toString(),
                          style: const TextStyle(
                              fontSize: 24, color: ColorConstants.colorWhite),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppLocalizations.of(context)!
                          .translate('signinSub')
                          .toString(),
                      style: const TextStyle(
                          fontSize: 18, color: ColorConstants.colorWhite),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Flexible(
                      flex: deviceSize.width > 600 ? 2 : 1,
                      child: AuthCard(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Text(
                        //   AppLocalizations.of(context)!
                        //       .translate('Message')
                        //       .toString(),
                        //   style: const TextStyle(fontSize: 32),
                        // ),
                        ElevatedButton(
                          onPressed: () {
                            appLanguage.changeLanguage(Locale("en"));
                            print(
                                "data..... ${AppLocalizations.of(context)!.translate('Signin').toString()}");
                            title.value = AppLocalizations.of(context)!
                                .translate('signin')
                                .toString();
                          },
                          child: const Text('English'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            appLanguage.changeLanguage(Locale("hi"));
                            // print(AppLocalizations.of(context)!
                            //     .translate('signin')
                            //     .toString());
                            // AppLocalizations.of(context)!
                            //     .translate('Message')
                            //     .toString();

                            title.value = AppLocalizations.of(context)!
                                .translate('signin')
                                .toString();
                          },
                          child: const Text('हिन्दी'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  // const AuthCard({
  //   required Key key,
  // }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences _sharedPreferences;
  bool _passwordVisible = false;
  @override
  void initState() {
    _prefs.then((SharedPreferences sharedPreferences) {
      _sharedPreferences = sharedPreferences;
    }).catchError((err) {
      UiUtils.errorSnackBar(message: 'Failed to get shared preference object!')
          .show();
    });
    _passwordVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  void _storeLoginData(String email, String isLogin) async {
    await _sharedPreferences.setString(PreferencesConstants.EMAIL, email);

    await _sharedPreferences.setString(PreferencesConstants.ISLOGIN, isLogin);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => Profile_Screen()));
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_authMode == AuthMode.Login) {
      // Log user in
      print('login data......');
      _storeLoginData(_emailController.text, "1");
    
    } else {
      // Sign user up
    }
    // setState(() {
    //   _isLoading = false;
    // });
  }
//not implementaed as said optional //PRAGNA
  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      height: _authMode == AuthMode.Signup ? 330 : 280,
      constraints:
          BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
      width: deviceSize.width * 0.75,
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //  Text(AppLocalizations.of(context)!.translate('signin').toString()),
              // Obx(() => Text(title.value)),
              TextFormField(
                controller: _emailController,
                style: const TextStyle(color: ColorConstants.colorWhite),
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!
                        .translate('email')
                        .toString(),
                    fillColor: ColorConstants.colorFieldColors,
                    filled: true),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Invalid email!';
                  }
                },
                onSaved: (value) {
                  _authData['email'] = value!;
                },
              ),
              TextFormField(
                style: const TextStyle(color: ColorConstants.colorWhite),
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!
                      .translate('password')
                      .toString(),
                  fillColor: ColorConstants.colorFieldColors,
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_passwordVisible,
                controller: _passwordController,
                validator: (value) {
                  if (value!.isEmpty || value.length < 5) {
                    return 'Password is too short!';
                  }
                },
                onSaved: (value) {
                  _authData['password'] = value!;
                },
              ),
              if (_authMode == AuthMode.Signup)
                TextFormField(
                  enabled: _authMode == AuthMode.Signup,
                  decoration:
                      const InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  validator: _authMode == AuthMode.Signup
                      ? (value) {
                          if (value != _passwordController.text) {
                            return 'Passwords do not match!';
                          }
                        }
                      : null,
                ),
              SizedBox(
                height: 20,
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(AppLocalizations.of(context)!
                      .translate('login')
                      .toString()),
                  style: ElevatedButton.styleFrom(
                      primary: ColorConstants.colorBtnSignIn),
                  onPressed: _submit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
