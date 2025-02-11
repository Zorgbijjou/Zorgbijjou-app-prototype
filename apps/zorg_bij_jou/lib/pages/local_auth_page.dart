import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:theme/assets/tokens/tokens.g.dart';
import 'package:zorg_bij_jou/routing/routing_constants.dart';

class LocalAuthPage extends ConsumerStatefulWidget {
  const LocalAuthPage({super.key});

  @override
  ConsumerState<LocalAuthPage> createState() => _LocalAuthPageState();
}

class _LocalAuthPageState extends ConsumerState<LocalAuthPage> {
  final LocalAuth localAuth = getIt();

  void _showLocalAuthDialog() async {
    bool authenticated = await localAuth.isLocallyAuthenticated(
      challengeReason: AppLocalizations.of(context)!.localAuthChallengeReason,
      cancelButton: AppLocalizations.of(context)!.localAuthCancelButton,
    );
    if (!mounted) return;
    if (authenticated) {
      context.go('/$supportHome');
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _showLocalAuthDialog();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'packages/onboarding/assets/images/onboarding-background.png'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 170,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.tokens.color.tokensTurqoise600,
                  ),
                  child:
                      const Image(image: AssetImage('assets/images/logo.png')),
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.zorgBijJou,
                  style: context.tokens.textStyle.tokensTypographyHeadingLg
                      .copyWith(color: context.tokens.color.tokensTurqoise800),
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.welcome,
                  style: context
                      .tokens.textStyle.tokensTypographyParagraphBoldMd
                      .copyWith(color: context.tokens.color.tokensTurqoise800),
                ),
                const SizedBox(height: 16),
                Button.primary(
                  label: AppLocalizations.of(context)!.localAuthChallengeAgain,
                  onPressed: _showLocalAuthDialog,
                ),
                const SizedBox(height: 16),
                Button.primary(
                  label: AppLocalizations.of(context)!.localAuthToOnboarding,
                  onPressed: () {
                    context.go('/$onboardingRoute');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
