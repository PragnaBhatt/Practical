import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:practical/api/api_urls.dart';
import 'package:practical/modules/login/models/login_model.dart';

import 'dio_client.dart';

class ApiImplementer {
//POST api
//parms in to json in body tested in to postman
  static Future<LoginModel> checkLoginApiImplementer({
    //response format
// /{
//     "code": 0,
//     "message": "success",
//     "data": {
//         "Id": 14112,
//         "Name": "Rajendra ",
//         "Email": "traveler@gmail.com",
//         "Token": "9cc8f07a-dcb5-4ae2-8d89-bcb7dc7baeec"
//     }
// }

//for invalid 
//Response ({"code":1,"message":"invalid username or password","data":null})
    required String user_name,
    required String password,
  }) async {
    final response = await DioClient.getDioClient()!.post(ApiUrls.LOGIN_URL,
        data: {
          'email': user_name,
          'password': password,
        },
        // options: Options(
        //     headers: {'Content-Type': Headers.formUrlEncodedContentType}));
          options: Options(
            headers: {'Content-Type': Headers.jsonContentType}));
    print(response.statusCode);
    print(response.data);

    if (response.statusCode == 200) {
      return LoginModel.fromJson(response.data);
    } else {
      throw Exception('Failed to login!');
    }
  }
}
