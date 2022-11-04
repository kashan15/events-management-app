import 'dart:io';

import 'package:democratic_unity/Model/user_model.dart';
import 'package:democratic_unity/modules/dio_service.dart';
import 'package:dio/dio.dart';

class SignupUser {
  var _dioService = DioService.getInstance();

  Future signupUser(UserModel userModel, String countryCode, String phoneNumber, String firebaseCurrentUserId,) async {
    try {
      var formData = FormData.fromMap({
        'country_code' : countryCode,
        'phone_no': phoneNumber,
        'FirebaseUserId' : firebaseCurrentUserId,
      });
      final response = await _dioService.post('SignUp', data: formData,options: Options(
        contentType: 'application/x-www-form-urlencoded'
      ));
      if(response.statusCode == 200){
        // user found
        if(response.data["status"] == 200){
          var userData = UserModel.fromJson(response.data['data']);
          return userData;
          //print(response.data);
          return true;
        }
        //user not found
        else {
          return response.data['message'];
        }
      }
      else{
        return response.statusMessage;
      }
    }
    catch (e) {
      dynamic exception = e;
      return exception.message;
    }
  }
}
