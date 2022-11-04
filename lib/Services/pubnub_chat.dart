
import 'package:democratic_unity/modules/dio_service.dart';

class PubNubChat {
  var dio = DioService.getInstance();

  Future chatDetails(String userId) async{
    try{
      final response = await dio.get('https://ps.pndsn.com/' +
          'v2/presence/sub-key/sub-c-e7663ff0-8d6f-11ec-b19d-ca42df2d7d16/uuid/${userId}');
      print(response);
      // if(response.statusCode == 200){
      //   if(response.data['status'] == 200){
      //     var details = response.data['data'];
      //     detailsList = [];
      //     for(var det in details){
      //       detailsList.add(EventsModel.fromJson(det));
      //     };
      //     //var attendeeDetails = AttendeeModel.fromJson(details);
      //     return detailsList;
      //   }
      //   else{
      //     return response.data['message'];
      //   }
      // }
      // else{
      //   return response.data['message'];
      // }
    }
    catch(e){
      print(e);
    }
  }

}