import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'users_providers.dart';

class UserDetailPage extends ConsumerWidget {
  final int userId;
  const UserDetailPage({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetail = ref.watch(userDetailProvider(userId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Detail'),
      ),
      body: userDetail.when(
        data: (user) {
          return ListView(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 20,
            ),
            children: [
              Text(
                user.name,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Divider(),
              UserInfo(
                iconData: Icons.account_circle,
                userInfo: user.username,
              ),
              const SizedBox(height: 10),
              UserInfo(
                iconData: Icons.email_rounded,
                userInfo: user.email,
              ),
              const SizedBox(height: 10),
              UserInfo(
                iconData: Icons.phone_enabled,
                userInfo: user.phone,
              ),
              const SizedBox(height: 10),
              UserInfo(
                iconData: Icons.web_rounded,
                userInfo: user.website,
              ),
            ],
          );
        },
        error: (e, st) {
          return Center(
            child: Text(
              e.toString(),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.red,
              ),
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  final IconData iconData;
  final String userInfo;
  const UserInfo({
    Key? key,
    required this.iconData,
    required this.userInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData),
        const SizedBox(width: 10),
        Text(
          userInfo,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}
