import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:theme/assets/tokens/tokens.g.dart';
import 'package:zorg_bij_jou/pages/local_auth_page.dart';
import 'package:zorg_bij_jou/routing/routing_constants.dart';

import '../helpers.dart';

void main() {
  MockLocalAuth localAuth = MockLocalAuth();

  setUp(() {
    getIt.registerSingleton<GoRouter>(MockGoRouter());
    getIt.registerSingleton<LocalAuth>(localAuth);
  });

  tearDown(() {
    getIt.reset();
  });

  testWidgets('LocalAuth page redirect when local auth successful',
      (WidgetTester tester) async {
    when(() => localAuth.isLocallyAuthenticated(
          challengeReason: any(named: 'challengeReason'),
          cancelButton: any(named: 'cancelButton'),
        )).thenAnswer((_) async => true);

    bool inSupportHome = false;
    // Act
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: ProviderContainer(),
        child: Tokens(
          tokens: DefaultTokens(),
          child: MaterialApp.router(
            routerConfig: GoRouter(initialLocation: '/', routes: [
              GoRoute(
                path: '/',
                builder: (context, state) {
                  return const LocalAuthPage();
                },
              ),
              GoRoute(
                path: '/$supportHome',
                builder: (context, state) {
                  inSupportHome = true;
                  return Container();
                },
              ),
              GoRoute(
                path: '/$onboardingRoute',
                builder: (context, state) {
                  return Container();
                },
              ),
            ]),
            localizationsDelegates: const [
              AppLocalizations.delegate,
            ],
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(inSupportHome, true);

    verify(() => localAuth.isLocallyAuthenticated(
          challengeReason: 'Unlock the Zorgbijjou app',
          cancelButton: 'Back',
        )).called(1);
  });

  testWidgets('LocalAuth page redirect to onboarding after unsuccessful',
      (WidgetTester tester) async {
    when(() => localAuth.isLocallyAuthenticated(
          challengeReason: any(named: 'challengeReason'),
          cancelButton: any(named: 'cancelButton'),
        )).thenAnswer((_) async => false);

    bool inOnboardingPage = false;
    // Act
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: ProviderContainer(),
        child: Tokens(
          tokens: DefaultTokens(),
          child: MaterialApp.router(
            routerConfig: GoRouter(initialLocation: '/', routes: [
              GoRoute(
                path: '/',
                builder: (context, state) {
                  return const LocalAuthPage();
                },
              ),
              GoRoute(
                path: '/$supportHome',
                builder: (context, state) {
                  return Container();
                },
              ),
              GoRoute(
                path: '/$onboardingRoute',
                builder: (context, state) {
                  inOnboardingPage = true;
                  return Container();
                },
              ),
            ]),
            localizationsDelegates: const [
              AppLocalizations.delegate,
            ],
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.text('Back to onboarding'));
    await tester.pump();

    expect(inOnboardingPage, true);

    verify(() => localAuth.isLocallyAuthenticated(
          challengeReason: 'Unlock the Zorgbijjou app',
          cancelButton: 'Back',
        )).called(1);
  });
}
