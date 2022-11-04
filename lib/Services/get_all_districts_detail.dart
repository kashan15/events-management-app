
import 'package:democratic_unity/Model/get_districts.dart';
import 'package:democratic_unity/modules/dio_service.dart';

class GetAllDistricts {
  var _dioService = DioService.getInstance();

  Future getDistDetails() async{
    try{
      final response = await _dioService.get('allRegionDetails');
      if(response.statusCode == 200){
        if(response.data['status'] == true){
          Map<String, dynamic> regionalDetails = response.data['data'];
          List regionalDistricts = regionalDetails["districts"];
          var gettingAllDistricts = regionalDistricts.map((e) => GetDistrictsModel.fromJson(e)).toList();
          // List<GetRegionalDetailsModel> gettingAllRegionalDetails =
          // regionalDetails.map((e) => GetRegionalDetailsModel.fromJson(e)).toList();
          // return gettingAllRegionalDetails;
          return gettingAllDistricts;
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