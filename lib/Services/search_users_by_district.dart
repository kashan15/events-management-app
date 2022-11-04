

import 'package:democratic_unity/Model/user_model.dart';
import 'package:democratic_unity/modules/dio_service.dart';

class SearchUsersByDistrict {
  var _dioService = DioService.getInstance();

  Future filterSearchedEvents(String district) async {
    try {
      final response = await _dioService.post('getUsersByDistrict', data: {
        'District': district,
      });
      if(response.statusCode == 200){
        if(response.data["status"] == 200){
          List<dynamic> userDetails = response.data['data'];
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