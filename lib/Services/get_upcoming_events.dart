import 'package:democratic_unity/Model/events_model.dart';
import 'package:democratic_unity/modules/dio_service.dart';

class GetAllEvents {
  var _dioService = DioService.getInstance();

  Future getAllEventsDetails() async{
    try{
      final response = await _dioService.get('getUpcomingEvents');
      // dynamic response = await _dioService.get('getUpcomingEvents');
      if(response.statusCode == 200){
        if(response.data['status'] == 200){
          List<dynamic> regionalDetails = response.data['data'];
          List gettingAllEvents = regionalDetails.map((e) => EventsModel.fromJson(e)).toList();
          return gettingAllEvents;
        }
        else{
          return response.data['message'];
        }
      }
      else{
        return response.data['message'];
      }
    }
    catch(e){
      print(e);
    }
  }

}