import 'package:democratic_unity/Model/volunteer_events_model.dart';
import 'package:democratic_unity/modules/dio_service.dart';

class GetVolunteerEventsByUserId {
  var _dioService = DioService.getInstance();

  Future getAllVolunteerEventsByUserId(String userId) async{
    // try{
    //   final response = await _dioService.get('getVolunteersByUserId', queryParameters: {
    //     'UserId': userId,
    //   });

      // try{
      //   final response = await _dioService.get('getVolunteersByUserId', queryParameters: {
      //     'UserId': userId,
      //   });
    try{
      final response = await _dioService.get('getVolunteersByUserId', queryParameters: {
        'UserId': userId,
      });

      if(response.statusCode == 200){
        if(response.data['status'] == 200){
          List<dynamic> details = response.data['data'];
          List gettingAllEvents = details.map((e) => VolunteerEventsModel.fromJson(e)).toList();
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