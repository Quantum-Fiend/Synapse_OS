import 'package:flutter_test/flutter_test.dart';
import 'package:synapseos_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('AuthBloc', () {
    late AuthBloc authBloc;

    setUp(() {
      authBloc = AuthBloc();
    });

    tearDown(() {
      authBloc.close();
    });

    test('initial state is AuthInitial', () {
      expect(authBloc.state, AuthInitial());
    });

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthAuthenticated] when LoginSubmitted is successful',
      build: () => authBloc,
      act: (bloc) => bloc.add(LoginSubmitted('admin', 'password')),
      expect: () => [
        AuthLoading(),
        AuthAuthenticated('mock_token'),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthError] when credentials are invalid',
      build: () => authBloc,
      act: (bloc) => bloc.add(LoginSubmitted('wrong', 'wrong')),
      expect: () => [
        AuthLoading(),
        AuthError('Invalid credentials'),
      ],
    );
  });
}
