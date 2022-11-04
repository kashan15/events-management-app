import 'package:democratic_unity/Model/events_model.dart';
import 'package:democratic_unity/modules/dio_service.dart';

class AllSearch {
  var _dioService = DioService.getInstance();

  Future keywordEvents(String keyword) async {
    try {
      final response = await _dioService.post('searchData', data: {
        'search': keyword,
      });
      if(response.statusCode == 200){
        if(response.data["status"] == 200){
          List<dynamic> regionalDetails = response.data['data']["events"];
          List gettingAllEvents = regionalDetails.map((e) => EventsModel.fromJson(e)).toList();
          return gettingAllEvents;
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