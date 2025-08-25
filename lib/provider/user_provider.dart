import 'package:riverpod/riverpod.dart';

final userProvider = StateProvider<User?>((ref) => null);

class User {
  final int id;
  final String nickname;
  final String accessToken;

  User({
    required this.id,
    required this.nickname,
    required this.accessToken,
  });
}
