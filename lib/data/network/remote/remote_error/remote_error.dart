import 'package:equatable/equatable.dart';

class RemoteError extends Equatable {
  final int statusCode;
  final String statusMessage;
  final bool success;

  const RemoteError({
    required this.statusCode,
    required this.statusMessage,
    required this.success,
  });

  factory RemoteError.fromJson(Map<String, dynamic> json) {
    return RemoteError(
      statusCode: json['status_code'],
      statusMessage: json['status_message'],
      success: json['success'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['status_message'] = statusMessage;
    data['success'] = success;
    return data;
  }

  @override
  List<Object> get props => [statusCode, statusMessage, success];
}
