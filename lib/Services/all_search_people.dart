import 'package:democratic_unity/Model/events_model.dart';
import 'package:democratic_unity/Model/user_model.dart';
import 'package:democratic_unity/modules/dio_service.dart';

class AllSearchPeople {
  var _dioService = DioService.getInstance();

  Future peopleSearch(String keyword) async {
    try {
      final response = await _dioService.post('searchData', data: {
        'search': keyword,
      });
      if(response.statusCode == 200){
        if(response.data["status"] == 200){
          List<dynamic> userDetails = response.data['data']["users"];
          List gettingAllUsers = userDetails.map((e) => UserModel.fromJson(e)).toList();
          return gettingAllUsers;
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