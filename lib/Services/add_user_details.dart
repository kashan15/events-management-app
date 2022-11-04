import 'dart:io';

import 'package:democratic_unity/modules/dio_service.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as path;

class UserDetailsService {
  var _dioService = DioService.getInstance();

  Future addUserDetail(
      String userId,
      String fName,
      String gender,
      String dob,
      String department,
      String province,
      String district,
      File? profileImage,
      String email,
      ) async {
    try {
      final response = await _dioService.post(
          'AddDetails',
        data: FormData.fromMap(
          {
              'UserId': userId,
              'fname' : fName,
              'gender': gender,
              'DOB' : dob,
              'department' : department,
              'province' : province,
              'district' : district,
            if(profileImage != null) 'ProfileImage' : await MultipartFile.fromFile(profileImage.path, filename: path.basename(profileImage.path)),
              'email' : email,
          },
        ),
      // {
      //   'UserId': userId,
      //   'fname' : fName,
      //   'gender': gender,
      //   'DOB' : dob,
      //   'department' : department,
      //   'province' : province,
      //   'district' : district,
      //   'ProfileImage' : await MultipartFile.fromFile(profileImage!.path, filename: path.basename(profileImage.path)).toString(),
      //   'email' : email,
      // }
      );
      if(response.statusCode == 200){
        if(response.data["status"] == true){
          return true;
        }
        else {
          return response.data['message'];
        }
      }
    }
    catch (e) {
      dynamic exception = e;
      return exception.message;
    }
  }
}