
import 'package:democratic_unity/Model/attendee.dart';
import 'package:democratic_unity/Model/events_model.dart';
import 'package:democratic_unity/Model/my_attending_events.dart';
import 'package:democratic_unity/modules/dio_service.dart';

class GetAttendingEvents {
  var _dioService = DioService.getInstance();

  Future getAttendingEventsDetails(AttendeeModel attendeeModel, String userId) async{
    try{
      final response = await _dioService.get('getAttendingEventsbyUser/$userId');
      print(response);
      if(response.statusCode == 200){
        if(response.data['status'] == 200){
          List<dynamic> attendeeDetails = response.data['data'];
          List<MyAttendeeModel> gettingAttendingEvents = attendeeDetails.map((e) => MyAttendeeModel.fromJson(e)).toList();
          return gettingAttendingEvents;
          // List<MyAttendeeModel> gettingAttendingEvents = attendeeDetails.map((e) => MyAttendeeModel().fromJson(e)).toList();
          // return gettingAttendingEvents;
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