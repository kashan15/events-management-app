
import 'package:democratic_unity/Model/user_model.dart';
import 'package:democratic_unity/modules/dio_service.dart';
import 'package:dio/dio.dart';

class MultipleAppUsers {
  var _dioService = DioService.getInstance();
  Future chatsUsers(
      List users,
      UserModel userModel,
      //String? currentProfilePic,
      ) async {
    try {
      final response = await _dioService.post(
        'multipleAppUsers',
        data: {
          'UserIds' : users,
        },
      );
      if(response.statusCode == 200){
        if(response.data["status"] == 200){
          List<UserModel> gettingUserDetails = (response.data["data"] as List).map((e) => UserModel.fromJson(e)).toList();
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