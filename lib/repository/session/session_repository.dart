import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tasklist_backend/hash_extension.dart';

@visibleForTesting
Map<String, Session> sessionDatabase = {};

class Session extends Equatable {
  const Session({
    required this.token,
    required this.userId,
    required this.createdAt,
    required this.expiryDate,
  });

  final String token;
  final String userId;
  final DateTime createdAt;
  final DateTime expiryDate;

  @override
  List<Object?> get props => [token, userId, createdAt, expiryDate];
}

class SessionRepository {
  Session createSession(String userId) {
    final now = DateTime.now();
    final session = Session(
      token: generateToken(userId),
      userId: userId,
      createdAt: now,
      expiryDate: now.add(const Duration(days: 1)),
    );
    sessionDatabase[session.token] = session;
    return session;
  }

  String generateToken(String userId) {
    return '${userId}_${DateTime.now().toIso8601String()}'.hashValue;
  }

  Session? sessionFromToken(String token) {
    final session = sessionDatabase[token];

    //Checking if the session exists and if its valid (the expiryDate has passed)
    if (session != null && session.expiryDate.isAfter(DateTime.now())) {
      return session;
    } else {
      return null;
    }
  }
}
