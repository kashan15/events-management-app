import 'package:democratic_unity/Model/user_model.dart';
import 'package:democratic_unity/modules/dio_service.dart';

class LoginUser {
  var _dioService = DioService.getInstance();

  Future loginUser(UserModel userModel, String countryCode, String phoneNumber) async {
    try {
      /// just login user through phoneNumber
      final response = await _dioService.post('login', data: {
        'country_code': countryCode,
        'phone_no': phoneNumber,
      });
      if(response.statusCode == 200){
        // user found
        if(response.data["status"] == 200){
          var userData = UserModel.fromJson(response.data['data']);
          return userData;
        }
        //user not found
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
