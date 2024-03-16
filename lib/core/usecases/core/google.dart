import 'package:equatable/equatable.dart';

abstract class GoogleUsecase<Type, Params, Credential> {
  const GoogleUsecase();

  Type call(Params params, Credential credential);
}

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object> get props => [];
}
