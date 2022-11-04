import 'package:democratic_unity/modules/dio_service.dart';

class VerifyForgetPassCode {
  var _dioService = DioService.getInstance();

  Future checkUser(String email, String code) async {
    try {
      final response = await _dioService.post('verifyForgetPassCode', data: {
        'email': email,
        'code': code,
      });
      if(response.statusCode == 200){
        if(response.data["status"] == true){
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