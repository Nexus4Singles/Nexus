// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class AppdataModel extends Equatable {
  final bool? isTest;
  const AppdataModel({
    this.isTest,
  });

  AppdataModel copyWith({
    bool? isTest,
  }) {
    return AppdataModel(
      isTest: isTest ?? this.isTest,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isTest': isTest,
    };
  }

  factory AppdataModel.fromMap(Map<String, dynamic> map) {
    return AppdataModel(
      isTest: map['isTest'] != null ? map['isTest'] as bool? : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppdataModel.fromJson(String source) =>
      AppdataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [isTest];
}
