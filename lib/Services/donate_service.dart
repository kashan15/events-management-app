
import 'package:democratic_unity/modules/dio_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DonateAPI {
  var _dioService = DioService.getInstance();

  Future doDonation(
      String userId,
      String name,
      String amount) async{
    try{
      final response = await _dioService.post('Donate', data: {
        'UserId': userId,
        'name' : name,
        'amount' : amount,
      });
      if(response.statusCode == 200){
        var postPaymentData = response.data["data"];
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

        //
        // await sharedPreferences.setString('paymentId', postPaymentData);
        // await sharedPreferences.setString('paymentType', 'card');
        //

        await sharedPreferences.setString('amount', amount);

        //
        // print(postPaymentData);
        //

      }
      else{
        print("something went wrong");
      }
    }
    catch(e){
      print(e);
    }
  }

}