import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/injector.dart';
import '../../../routes/routes.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            ref.read(authenticationRepositoryProvider).signOut();
            Navigator.pushReplacementNamed(context, Routes.signIn);
          },
          child: const Text('Sign Out'),
        ),
      ),
    );
  }
}
