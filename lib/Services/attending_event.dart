
import 'package:democratic_unity/modules/dio_service.dart';
import 'package:dio/dio.dart';

// class AttendEvent {
//   var _dioService = DioService.getInstance();
//
//   Future attendingTheEvents(String userId, String fName,String id,) async {
//     try {
//       final response = await _dioService.post('addAttendee',data: {
//         'UserId': userId,
//         'fname': fName,
//         'Id': id,
//       });
//       print(response);
//
//       if(response.statusCode == 200){
//         if(response.data["status"] == 200){
//           return true;
//         }
//         //user not found
//         else {
//           return response.data['message'];
//         }
//       }
//       else{
//         return ("some thing went wrong");
//       }
//     }
//     catch (e) {
//       dynamic exception = e;
//       return exception.message;
//     }
//   }
//
// }

class AttendEvent {
  var _dioService = DioService.getInstance();

  Future attendingTheEvents(String userId,
      // String userIdPref,
      String fName,
      // String Fname,
      // String Id,
      String id,
      ) async {
    try {
      var eventParams = FormData.fromMap({
        'UserId': userId,
        // 'UserId': firebaseCurrentUserId,
        'fname': fName,
        // 'Id': Id,
        'Id': id
      });
      print(eventParams);


      final response = await _dioService.post('addAttendee',data: eventParams);
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

