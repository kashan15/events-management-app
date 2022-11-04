
import 'package:democratic_unity/modules/dio_service.dart';

class PostStatus {
  var _dioService = DioService.getInstance();

  Future postStatus(
      String userId,
      String statusValue
      ) async {
    try {
      /// just login user through phoneNumber
      final response = await _dioService.post('PostStatus', data: {
        'UserId': userId,
        'status': statusValue,
      });
      if(response.statusCode == 200){
        // user found
        if(response.data["status"] == 200){
          return "online";
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