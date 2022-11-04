
import 'package:democratic_unity/Model/attendee.dart';
import 'package:democratic_unity/modules/dio_service.dart';

class GetAttendee {
  var _dioService = DioService.getInstance();
  List<AttendeeModel> detailsList = [];

  // Future getAllEventsDetails(AttendeeModel attendeeModel, String eventId) async{
    Future getAllEventsDetails(AttendeeModel attendeeModel, String eventId) async{
    try{
      // final response = await _dioService.get('getAttendee/$eventId');
      final response = await _dioService.get('getAttendee/$eventId');
      print(response);

      if(response.statusCode == 200){
        if(response.data['status'] == 200){
          var details = response.data['data'];
          detailsList = [];
          for(var det in details){
            detailsList.add(AttendeeModel.fromJson(det));
          };
          //var attendeeDetails = AttendeeModel.fromJson(details);
          print(detailsList);
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