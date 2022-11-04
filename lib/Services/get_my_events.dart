import 'package:democratic_unity/Model/attendee.dart';
import 'package:democratic_unity/Model/events_model.dart';
import 'package:democratic_unity/modules/dio_service.dart';

class GetMyEvents {
  var _dioService = DioService.getInstance();
  List<EventsModel> detailsList = [];

  Future getMyEventsDetails(EventsModel eventsModel, String userId) async{
    try{
      final response = await _dioService.get('getEventsbyUser/$userId');
      if(response.statusCode == 200){
        if(response.data['status'] == 200){
          var details = response.data['data'];
          detailsList = [];
          for(var det in details){
            detailsList.add(EventsModel.fromJson(det));
          };
          //var attendeeDetails = AttendeeModel.fromJson(details);
          return detailsList;
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