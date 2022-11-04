import 'dart:io';
import 'package:democratic_unity/Model/user_model.dart';
import 'package:democratic_unity/modules/dio_service.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;

class UpdateProfileService {
  var _dioService = DioService.getInstance();

  Future updateDetail(
      String userId,
      String fName,
      String gender,
      String dob,
      String department,
      String province,
      String district,
      File? profileImage,
      //String? currentProfilePic,
      ) async {
    try {
      var data = FormData.fromMap(
        {
          'UserId': userId,
          'fname' : fName,
          'gender': gender,
          'DOB' : dob,
          'department' : department,
          'province' : province,
          'district' : district,
          //'ProfileImage' : profileImage != null ? await MultipartFile.fromFile(profileImage.path, filename: path.basename(profileImage.path)) : null,
          if(profileImage != null) 'ProfileImage' : await MultipartFile.fromFile(profileImage.path, filename: path.basename(profileImage.path)),
        },
      );
      final response = await _dioService.post(
        'addDetailsUpdate',
        data: data,
      options: Options(
          contentType: Headers.formUrlEncodedContentType
      ));
      if(response.statusCode == 200){
        if(response.data["status"] == true){
          var gettingUserDetails = UserModel.fromJson(response.data['data'][0]);
          return gettingUserDetails;
          //return true;
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