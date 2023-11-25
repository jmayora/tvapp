import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/providers.dart';
import '../../../routes/routes.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends ConsumerState<SplashView> {
  bool hasInternet = false;
  bool isSignedIn = false;
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final connectivityRepository = ref.read(connectivityRepositoryProvider);
    final authenticationRepository = ref.read(authenticationRepositoryProvider);
    final hasInternet = await connectivityRepository.hasInternet;
    if (hasInternet) {
      final isSignedIn = await authenticationRepository.isSignedIn;
      if (isSignedIn) {
        final user = await authenticationRepository.getUserData();
        if (mounted) {
          if (user != null) {
            _goTo(Routes.home);
          } else {
            _goTo(Routes.signIn);
          }
        }
      } else if (mounted) {
        _goTo(Routes.signIn);
      }
    } else {
      _goTo(Routes.offline);
    }
  }

  void _goTo(String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 80,
          height: 80,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
