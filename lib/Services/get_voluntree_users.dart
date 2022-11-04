import 'package:democratic_unity/Model/attendee.dart';
import 'package:democratic_unity/modules/dio_service.dart';

class GetVoluntree {
  var _dioService = DioService.getInstance();
  List<AttendeeModel> detailsList = [];

  Future getAllVoluntreeDetails(AttendeeModel attendeeModel,
      // String eventId
      String Id
      ) async{
    print(Id);
    try{
      // final response = await _dioService.get('getVolunteerUsers/$eventId');
      final response = await _dioService.get('getVolunteerUsers/$Id');
      // final response = await _dioService.get('getVolunteersEvents');
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