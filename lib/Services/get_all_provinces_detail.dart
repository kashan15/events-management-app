import 'package:democratic_unity/Model/get_provinces.dart';
import 'package:democratic_unity/modules/dio_service.dart';

class GetAllProvinces {
  var _dioService = DioService.getInstance();

  Future getProvDetails() async{
    try{
      final response = await _dioService.get('allRegionDetails');
      if(response.statusCode == 200){
        if(response.data['status'] == true){
          Map<String, dynamic> regionalDetails = response.data['data'];
          List regionalProvinces = regionalDetails["provinces"];
          var gettingAllProvinces = regionalProvinces.map((e) => GetProvincesModel.fromJson(e)).toList();
          // List<GetRegionalDetailsModel> gettingAllRegionalDetails =
          // regionalDetails.map((e) => GetRegionalDetailsModel.fromJson(e)).toList();
          // return gettingAllRegionalDetails;
          return gettingAllProvinces;
        }
        else{
          print("something went wrong");
          return [];
        }
      }
      else{
        print("something went wrong");
        return [];
      }
    }
    catch(e){
      print(e);
    }
  }

}