import '../../domain/entities/response_entity.dart';

class ResponseModel extends ResponseEntity {
  ResponseModel({
    required Map<String, dynamic> map,
  }) : super(user: map);

  factory ResponseModel.fromJson(Map<String, dynamic> map) {
    return ResponseModel(map: map['data']['user']);
  }

  factory ResponseModel.fromJsonAllUsers(Map<String, dynamic> map) {
    return ResponseModel(map: map['data']);
  }
}
