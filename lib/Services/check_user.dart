import 'package:democratic_unity/modules/dio_service.dart';

class CheckUser {
  var _dioService = DioService.getInstance();

  Future checkUser(String email, String phoneNo) async {
    try {
      final response = await _dioService.post('checkUser', data: {
        'email': email,
        'phone_no': phoneNo,
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