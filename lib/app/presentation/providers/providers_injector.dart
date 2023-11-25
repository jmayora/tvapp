import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../data/http/http.dart';
import '../../data/repositories_implementation/repositories_impl.dart';
import '../../data/services/remote/authentication_api.dart';
import '../../data/services/remote/internet_checker.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../../domain/repositories/connectivity_repository.dart';

class ProvidersInjector {
  ConnectivityRepository get connectivityRepository =>
      ConnectivityRepositoryImpl(
        Connectivity(),
        InternetChecker(),
      );
  AuthenticationRepository get authenticationRepository =>
      AuthenticationRepositoryImpl(
        const FlutterSecureStorage(),
        AuthenticationAPI(
          Http(
            client: http.Client(),
            baseUrl: 'https://api.themoviedb.org/3',
            apiKey: '1d09f0efd6203f96c7c9e21b5e205bcb',
          ),
        ),
      );
}
