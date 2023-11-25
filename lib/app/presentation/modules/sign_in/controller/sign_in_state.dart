class SignInState {
  SignInState({
    this.username = '',
    this.password = '',
    this.fetching = false,
  });

  String username, password;
  bool fetching;
}
