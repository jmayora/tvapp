import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/enums.dart';
import '../../../providers/providers.dart';
import '../../../routes/routes.dart';

class SubmitButton extends ConsumerWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fetching = ref.read(signInControllerProvider).fetching;

    if (fetching) {
      return const CircularProgressIndicator();
    } else {
      return MaterialButton(
        color: Colors.blue,
        onPressed: () {
          final isValid = Form.of(context).validate();
          if (isValid) {
            _submit(context, ref);
          }
        }, //
        child: const Text('Sign In'),
      );
    }
  }

  Future<void> _submit(BuildContext context, WidgetRef ref) async {
    final authenticationRepository = ref.read(authenticationRepositoryProvider);

    final signInState = ref.read(signInControllerProvider);
    final username = signInState.username;
    final password = signInState.password;

    ref.read(signInControllerProvider.notifier).setFetching(true);
    final result = await authenticationRepository.signIn(
      username,
      password,
    );

    if (!context.mounted) {
      return;
    }
    result.when(
      (failure) {
        ref.read(signInControllerProvider.notifier).setFetching(false);

        final message = {
          SignInFailure.notFound: 'Not Found',
          SignInFailure.unauthorized: 'Invalid name/password',
          SignInFailure.unknown: 'Error',
          SignInFailure.network: 'Network failure',
        }[failure];

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message!),
          ),
        );
      },
      (user) {
        Navigator.pushReplacementNamed(
          context,
          Routes.home,
        );
      },
    );
  }
}
