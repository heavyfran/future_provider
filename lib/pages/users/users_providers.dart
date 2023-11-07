import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user.dart';
import '../../providers/dio_provider.dart';

final userListProvider = FutureProvider.autoDispose<List<User>>((ref) async {
  ref.onDispose(() {
    print('[userListProvider] disposed');
  });
  final response = await ref.watch(dioProvider).get('/users');
  // throw 'Fail to fetch user list';
  final List userList = response.data;
  final users = [for (final user in userList) User.fromJson(user)];
  return users;
});
