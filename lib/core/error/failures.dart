import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  final String message;

  ServerFailure({required this.message});
  @override
  List<Object> get props => [message];
}
class CheckYourNetwork extends Failure{}
class CacheFailure extends Failure {}
class LoginFailure extends Failure {}
class ReLoginFailure extends Failure {}
class SendDataFailure extends Failure {}