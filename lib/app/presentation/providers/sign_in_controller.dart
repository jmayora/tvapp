import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../modules/sign_in/controller/sign_in_state.dart';

part 'sign_in_controller.g.dart';

@riverpod
class SignInController extends _$SignInController {
  @override
  SignInState build() {
    return const SignInState(username: '', password: '', fetching: false);
  }

  void setUsername(String text) {
    state = state.copyWith(username: text);
  }

  void setPassword(String text) {
    state = state.copyWith(password: text);
  }

  void setFetching(bool value) {
    state = state.copyWith(fetching: value);
  }
}

/* @riverpod
class Fetching extends _$Fetching {
  @override
  bool build() {
    return false;
  }

  void setFetching(bool value) {
    state = value;
  }
} */
