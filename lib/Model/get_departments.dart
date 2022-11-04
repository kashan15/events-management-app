import 'package:json_annotation/json_annotation.dart';

part 'get_departments.g.dart';

@JsonSerializable()
class GetDepartmentsModel {
  GetDepartmentsModel();

  String? id;
  String? deptName;


  factory GetDepartmentsModel.fromJson(Map<String, dynamic> json) => _$GetDepartmentsModelFromJson(json);
  Map<String, dynamic> toJson() => _$GetDepartmentsModelToJson(this);

}
