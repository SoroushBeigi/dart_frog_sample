import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@visibleForTesting
Map<String, Session> sessionDatabase = {};

class Session extends Equatable {
  const Session({
    required this.token,
    required this.userID,
    required this.createdAt,
    required this.expireDate,
  });

  final String token;
  final String userID;
  final DateTime createdAt;
  final DateTime expireDate;

  @override
  List<Object?> get props => [token, userID, createdAt, expireDate];
}
