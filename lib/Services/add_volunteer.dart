
import 'package:democratic_unity/Model/volunteer_events_model.dart';
import 'package:democratic_unity/modules/dio_service.dart';

class AddVolunteer {
  var _dioService = DioService.getInstance();

  Future volunteerTheEvent(String userId,
      String eventId,
      // String EventId,
      // String Id,
      String volunteeringJobs, String eventName) async {
    try {
      final response = await _dioService.post('Volunteer', data: {
        'UserId': userId,
        'Id': eventId,
        // 'Id': EventId,
        // 'Id': Id,
        'volunteertypes': volunteeringJobs,
        'name': eventName,
      });
      print(response);
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