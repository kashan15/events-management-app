
import 'package:democratic_unity/Model/user_model.dart';
import 'package:democratic_unity/modules/dio_service.dart';

class GetUserDetails {
  var _dioService = DioService.getInstance();

  Future getUsersDetails(UserModel userModel, String userId) async{
    try{
      final response = await _dioService.get('getAppUsers', queryParameters: {
        'UserId': userId,
      });
      if(response.statusCode == 200){
        if(response.data['status'] == 200){
          var gettingUserDetails = UserModel.fromJson(response.data['data'][0]);
          return gettingUserDetails;
        }
        else{
          print("something went wrong");
          return [];
        }
      }
      else{
        print("something went wrong");
        return [];
      }
    }
    catch(e){
      print(e);
    }
  }

}