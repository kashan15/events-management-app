import 'package:democratic_unity/modules/dio_service.dart';

class ForgetPassword {
  var _dioService = DioService.getInstance();

  Future forgetPasswordEmail(String email,) async {
    try {
      /// just login user through phoneNumber and password
      final response = await _dioService.post('resetPassword', data: {
        'email': email,
      });
      if(response.statusCode == 200){
        // user found
        if(response.data["status"] == 200){
          return true;
        }
        //user not found
        else {
          //print(response.data['message']);
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