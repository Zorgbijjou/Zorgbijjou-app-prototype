import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zorg_bij_jou/pages/conversation_page.dart';
import 'package:zorg_bij_jou/pages/conversations_page.dart';
import 'package:zorg_bij_jou/pages/developer_settings_page.dart';
import 'package:zorg_bij_jou/pages/home_page.dart';
import 'package:zorg_bij_jou/pages/local_auth_page.dart';
import 'package:zorg_bij_jou/pages/not_found_page.dart';
import 'package:zorg_bij_jou/pages/support_question_page.dart';
import 'package:zorg_bij_jou/pages/support_subject_page.dart';
import 'package:zorg_bij_jou/providers/dev_mode_provider.dart';
import 'package:zorg_bij_jou/providers/local_auth_enabled_provider.dart';
import 'package:zorg_bij_jou/routing/analytics_observer.dart';
import 'package:zorg_bij_jou/routing/routing_constants.dart';
import 'package:zorg_bij_jou/routing/scaffold_nested_navigation.dart';

import '../pages/login_information_page.dart';
import '../pages/onboarding_page.dart';
import '../pages/terms_and_conditions_page.dart';
import '../providers/grid_overlay_enabled_provider.dart';

var goRouterProvider = Provider((ref) {
  var isDevMode = ref.watch(devModeProvider);
  var isGridOverlayEnabled = ref.watch(gridOverlayEnabledProvider);
  var isLocalAuthEnabled = ref.watch(localAuthEnabledProvider);

  return createRouter(
    isDevMode: isDevMode,
    isGridOverlayEnabled: isGridOverlayEnabled,
    isLocalAuthEnabled: isLocalAuthEnabled,
  );
});

createRouter({
  bool isDevMode = false,
  bool isGridOverlayEnabled = false,
  bool isLocalAuthEnabled = false,
}) {
  var shellNavigatorSupportKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellSupport');
  var shellNavigatorConversationsKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellConversations');
  LocalStorage onboardingStorage = getIt();
  Auth auth = getIt();

  return GoRouter(
    observers: [AnalyticsObserver()],
    onException: (context, GoRouterState state, GoRouter router) {
      router.go('/404', extra: state.uri.toString());
    },
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNestedNavigation(
              navigationShell: navigationShell,
              isDevMode: isDevMode,
              isGridOverlayEnabled: isGridOverlayEnabled);
        },
        branches: [
          StatefulShellBranch(
            observers: [AnalyticsObserver()],
            navigatorKey: shellNavigatorSupportKey,
            routes: [
              GoRoute(
                name: 'Support home',
                path: '/$supportHome',
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey, //
                  name: state.name,
                  child: const HomePage(),
                ),
                routes: [
                  GoRoute(
                    name: 'Support question',
                    path: '$supportQuestionRoute/:questionSlug',
                    builder: (context, state) {
                      var slug = state.pathParameters['questionSlug'];

                      if (slug == null) {
                        throw Exception();
                      }

                      return SupportQuestionPage(slug: slug);
                    },
                  ),
                  GoRoute(
                      name: 'Support subject',
                      path: '$supportSubjectRoute/:subjectSlug',
                      builder: (context, state) {
                        var slug = state.pathParameters['subjectSlug'];

                        if (slug == null) {
                          throw Exception();
                        }

                        return SupportSubjectPage(slug: slug);
                      },
                      routes: [
                        GoRoute(
                          name: 'Support question in subject',
                          path: '$supportQuestionRoute/:questionSlug',
                          builder: (context, state) {
                            var slug = state.pathParameters['questionSlug'];

                            if (slug == null) {
                              throw Exception();
                            }

                            return SupportQuestionPage(slug: slug);
                          },
                        ),
                      ]),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            observers: [AnalyticsObserver()],
            navigatorKey: shellNavigatorConversationsKey,
            routes: [
              GoRoute(
                name: 'Chat Conversations home',
                path: '/$chatConversations',
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey, //
                  name: state.name,
                  child: const ConversationsPage(),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/',
        redirect: (context, state) async {
          if (await auth.hasRefreshToken() &&
              onboardingStorage.isOnboardingFinished()) {
            if (isLocalAuthEnabled) {
              return '/$localAuthRoute';
            }

            return '/$supportHome';
          }

          return '/$onboardingRoute';
        },
      ),
      GoRoute(
        name: 'Chat Conversation',
        path: '/$chatConversations/:conversationId',
        builder: (context, state) {
          String? conversationId = state.pathParameters['conversationId'];
          if (conversationId == null) {
            throw Exception();
          }

          return ConversationPage(conversationId: conversationId);
        },
      ),
      GoRoute(
        name: 'Onboarding',
        path: '/$onboardingRoute',
        builder: (context, state) {
          return const OnboardingPage();
        },
        routes: [
          GoRoute(
            name: 'Terms and Conditions page',
            path: termsAndConditionsRoute,
            builder: (context, state) {
              return const TermsAndConditionsPage();
            },
          ),
          GoRoute(
            name: 'Login Information page',
            path: loginInformationRoute,
            builder: (context, state) {
              return const LoginInformationPage();
            },
          ),
        ],
      ),
      GoRoute(
        name: 'Local Auth',
        path: '/$localAuthRoute',
        builder: (BuildContext context, GoRouterState state) {
          return const LocalAuthPage();
        },
      ),
      GoRoute(
        name: 'Developer settings',
        path: '/$devSettings',
        builder: (BuildContext context, GoRouterState state) {
          return const DeveloperSettingsPage();
        },
      ),
      GoRoute(
        name: '404 - Not Found',
        path: '/404',
        builder: (BuildContext context, GoRouterState state) {
          var uri = state.extra as String? ?? '';
          return NotFoundPage(uri: uri);
        },
      ),
    ],
  );
}
