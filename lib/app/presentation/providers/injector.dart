import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/repositories/authentication_repository.dart';
import '../../domain/repositories/connectivity_repository.dart';
import 'providers_injector.dart';

part 'injector.g.dart';

@Riverpod(keepAlive: true)
ConnectivityRepository connectivityRepository(ConnectivityRepositoryRef ref) {
  return ProvidersInjector().connectivityRepository;
}

@Riverpod(keepAlive: true)
AuthenticationRepository authenticationRepository(
    AuthenticationRepositoryRef ref) {
  return ProvidersInjector().authenticationRepository;
}
