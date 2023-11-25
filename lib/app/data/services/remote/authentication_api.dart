import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../http/http.dart';

class AuthenticationAPI {
  AuthenticationAPI(this._http);

  final Http _http;
  //final Client _client;
  static const apiKey = '1d09f0efd6203f96c7c9e21b5e205bcb';
  static const urlBase = 'https://api.themoviedb.org/3';

  static const urlRequestToken = '/authentication/token/new';

  static const urlCreateSessionWithLogin =
      '/authentication/token/validate_with_login';

  static const urlCreateSession = '/authentication/session/new';

  Either<SignInFailure, String> _handleFailure(HttpFailure failure) {
    if (failure.statusCode != null) {
      switch (failure.statusCode) {
        case 401:
          return Either.left(SignInFailure.unauthorized);
        case 404:
          return Either.left(SignInFailure.notFound);

        default:
          return Either.left(SignInFailure.unknown);
      }
    } else if (failure.exception is NetworkException) {
      return Either.left(SignInFailure.network);
    } else {
      return Either.left(SignInFailure.unknown);
    }
  }

  Future<Either<SignInFailure, String>> createRequestToken() async {
    final result = await _http.request(
      urlRequestToken,
      onSuccess: (responseBody) {
        final json = responseBody as Map;
        return json['request_token'] as String;
      },
    );
    return result.when(
      _handleFailure,
      (requestToken) => Either.right(
        requestToken,
      ),
    );
  }

  Future<Either<SignInFailure, String>> createSessionWithLogin({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final result = await _http.request(
      urlCreateSessionWithLogin,
      method: HttpMethod.post,
      body: {
        'username': username,
        'password': password,
        'request_token': requestToken,
      },
      onSuccess: (responseBody) {
        final json = responseBody as Map;
        return json['request_token'] as String;
      },
    );

    return result.when(
      _handleFailure,
      (newRequestToken) => Either.right(newRequestToken),
    );
  }

  Future<Either<SignInFailure, String>> createSession(
      String requestToken) async {
    final result = await _http.request(
      urlCreateSession,
      method: HttpMethod.post,
      body: {
        'request_token': requestToken,
      },
      onSuccess: (responseBody) {
        final json = responseBody as Map;
        return json['session_id'] as String;
      },
    );

    return result.when(
      _handleFailure,
      (newSessionId) => Either.right(newSessionId),
    );
  }
}
