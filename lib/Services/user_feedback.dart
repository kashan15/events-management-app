
import 'package:democratic_unity/modules/dio_service.dart';

class UserFeedback {
  var _dioService = DioService.getInstance();

  Future usersFeedBack(String userId, String title, String description) async {
    try {
      final response = await _dioService.post('userFeedback', data: {
        'UserId': userId,
        'title': title,
        'description': description,
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