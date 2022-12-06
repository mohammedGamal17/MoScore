import 'package:equatable/equatable.dart';

import '../../data/network/remote/remote_error/remote_error.dart';

abstract class Failure extends Equatable {
  final String message;
  final int code;

  const Failure(this.code, this.message);

  @override
  List<Object> get props => [message, code];
}

class RemoteErrorImplement extends Failure {
  const RemoteErrorImplement(super.code, super.message);
}

class LocalErrorImplement extends Failure {
  const LocalErrorImplement(super.code, super.message);
}

class RemoteErrorHandlerException implements Exception {
  final RemoteError remoteError;

  RemoteErrorHandlerException(this.remoteError);
}

class LocalErrorHandlerException implements Exception {}