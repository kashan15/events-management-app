
import 'package:democratic_unity/Model/attendee.dart';
import 'package:democratic_unity/Model/events_model.dart';
import 'package:democratic_unity/modules/dio_service.dart';

class GetNearByEvents {
  var _dioService = DioService.getInstance();
  List<EventsModel> detailsList = [];

  Future getNearByEventsDetails(EventsModel eventsModel, String userId, String district) async{
    try{
      final response = await _dioService.get('getEventsNearbyUser', queryParameters: {
        'userId': userId,
        'district' : district
      });
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