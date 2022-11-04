
import 'package:democratic_unity/modules/dio_service.dart';

class ResetThePassword {
  var _dioService = DioService.getInstance();

  Future confirmPassword(String email, String password) async {
    try {
      final response = await _dioService.post('confirmPassword', data: {
        'email': email,
        'password': password,
      });
      if(response.statusCode == 200){
        if(response.data["status"] == 200){
          return true;
        }
        else {
          return response.data['message'];
        }
      }
      else{
        return ("some thing went wrong");
      }
    }
    catch (e) {
      dynamic exception = e;
      return exception.message;
    }
  }

}