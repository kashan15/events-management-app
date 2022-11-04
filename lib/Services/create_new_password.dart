import 'package:democratic_unity/modules/dio_service.dart';

class CreatingNewPassword {
  var _dioService = DioService.getInstance();

  Future createNewPassword(String userId, String oldPassword, String newPassword, String confirmNewPassword) async {
    try {
      final response = await _dioService.post('CreateNewPassword', data: {
        'UserId': userId,
        'OldPassword': oldPassword,
        'NewPassword': newPassword,
        'ConfirmNewPassword': confirmNewPassword,
      });
      if(response.statusCode == 200){
        if(response.data["status"] == 200){
          return true;
        }
        //user not found
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