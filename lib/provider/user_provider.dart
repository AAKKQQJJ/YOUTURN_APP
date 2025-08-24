import 'package:riverpod/riverpod.dart';

final userProvider = StateProvider<User?>((ref) => null);

class User {
  final String nickname;
  final String accessToken;

  User({required this.nickname, required this.accessToken});
}
