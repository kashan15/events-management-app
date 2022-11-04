import 'package:democratic_unity/Model/events_model.dart';
import 'package:democratic_unity/Model/volunteer_events_model.dart';
import 'package:democratic_unity/modules/dio_service.dart';

class GetVolunteerEvents {
  var _dioService = DioService.getInstance();

  Future getAllVolunteerEventsDetails() async{
    try{
      final response = await _dioService.get('getVolunteersEvents');
      if(response.statusCode == 200){
        if(response.data['status'] == 200){
          List<dynamic> details = response.data['data'];
          List gettingAllVolunteerEvents = details.map((e) => EventsModel.fromJson(e)).toList();
          return gettingAllVolunteerEvents;
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