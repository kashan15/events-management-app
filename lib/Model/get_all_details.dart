import 'package:democratic_unity/Model/get_departments.dart';
import 'package:democratic_unity/Model/get_districts.dart';
import 'package:democratic_unity/Model/get_provinces.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_details.g.dart';

@JsonSerializable()
class GetRegionalDetailsModel {
  GetRegionalDetailsModel();

  List<GetDepartmentsModel>? departments;
  List<GetProvincesModel>? provinces;
  List<GetDistrictsModel>? districts;


  factory GetRegionalDetailsModel.fromJson(Map<String, dynamic> json) => _$GetRegionalDetailsModelFromJson(json);
  Map<String, dynamic> toJson() => _$GetRegionalDetailsModelToJson(this);

}
