import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/models/user.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/repo.dart';

class UserFilterParams extends Equatable {
  final UserModel user;
  final String? city;
  final String? country;
  final int? age;
  final String? gender;
  final List<String>? similarHobbies;
  final List<String>? similarDesiredQualities;
  final String? churchName;

  const UserFilterParams({
    required this.user,
    this.city,
    this.country,
    this.age,
    this.gender,
    this.similarHobbies,
    this.similarDesiredQualities,
    this.churchName,
  });

  @override
  List<Object?> get props => [
        city,
        country,
        age,
        gender,
        similarHobbies,
        similarDesiredQualities,
        churchName,
      ];
}

@lazySingleton
class GetUsersFilterableUseCase extends Usecase<void, UserFilterParams> {
  GetUsersFilterableUseCase({
    required this.repository,
  });

  final HomeRepository repository;

  @override
  Future<Either<void, List<UserModel>>> call(params) async =>
      await repository.getUsersFilterable(user: params.user);
}
