import 'package:core/l10n/core_localizations.dart';
import 'package:core/mocks/mock_translation_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:onboarding/onboarding.dart';
import 'package:onboarding/view_models/onboarding_view_model.dart';
import 'package:theme/theme.dart';

class OnboardingTestComponent extends OnboardingComponent {
  final Widget child;
  final IconData iconData;

  OnboardingTestComponent(this.child, this.iconData, {Key? key})
      : super(globalKey: GlobalKey());

  @override
  OnboardingComponentState createState() => _OnboardingTestComponentState();
}

class _OnboardingTestComponentState
    extends OnboardingComponentState<OnboardingTestComponent> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  Widget buildActionButton(BuildContext context) {
    return IconButton(
      key: const Key('emptyNextButton'),
      icon: Icon(widget.iconData),
      onPressed: () {},
    );
  }
}

void main() {
  testWidgets('Onboarding switches page when pressing next',
      (WidgetTester tester) async {
    var mockTranslationRepository = MockTranslationRepository();
    var pageController = PageController();

    await tester.pumpWidget(MaterialApp(
      home: Localizations(
        delegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        locale: const Locale('nl'),
        child: Tokens(
          tokens: DefaultTokens(),
          child: Onboarding(
            viewModel: OnboardingViewModel(
                pageController: pageController,
                components: [
                  OnboardingTestComponent(const Text('Page 1'), Icons.check),
                  OnboardingTestComponent(
                      const Text('Page 2'), Icons.arrow_forward),
                ]),
            translationRepository: mockTranslationRepository,
          ),
        ),
      ),
    ));

    // Assert
    expect(find.text('Page 1'), findsOneWidget);
    expect(find.text('Page 2'), findsNothing);

    pageController.nextPage(
        duration: const Duration(milliseconds: 1), curve: Curves.ease);

    await tester.pumpAndSettle();

    // Assert
    expect(find.text('Page 1'), findsNothing);
    expect(find.text('Page 2'), findsOneWidget);
  });

  // switches buttons when pressing next
  testWidgets('Onboarding shows button for second page',
      (WidgetTester tester) async {
    var mockTranslationRepository = MockTranslationRepository();

    var pageController = PageController();

    var secondPageIndex = 1;

    await tester.pumpWidget(MaterialApp(
      home: Localizations(
        delegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        locale: const Locale('nl'),
        child: Tokens(
          tokens: DefaultTokens(),
          child: Onboarding(
            viewModel: OnboardingViewModel(
              pageController: pageController,
              components: [
                OnboardingTestComponent(const Text('Page 1'), Icons.check),
                OnboardingTestComponent(
                    const Text('Page 2'), Icons.arrow_forward),
              ],
              currentPage: secondPageIndex,
            ),
            translationRepository: mockTranslationRepository,
          ),
        ),
      ),
    ));

    pageController.jumpToPage(secondPageIndex);

    await tester.pumpAndSettle();

    expect(find.widgetWithIcon(IconButton, Icons.check), findsNothing);
    expect(
        find.widgetWithIcon(IconButton, Icons.arrow_forward), findsOneWidget);
  });

  // expect navigate back when back button is pressed
  testWidgets('Onboarding navigates back when back button is pressed',
      (WidgetTester tester) async {
    var mockTranslationRepository = MockTranslationRepository();

    var pageController = PageController();

    await tester.pumpWidget(MaterialApp(
      home: Localizations(
        delegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        locale: const Locale('nl'),
        child: Tokens(
          tokens: DefaultTokens(),
          child: Onboarding(
            viewModel: OnboardingViewModel(
              pageController: pageController,
              currentPage: 3,
              components: [
                OnboardingTestComponent(const Text('Page 1'), Icons.check),
                OnboardingTestComponent(
                    const Text('Page 2'), Icons.arrow_forward),
                OnboardingTestComponent(
                    const Text('Page 3'), Icons.arrow_forward),
                OnboardingTestComponent(
                  const Text('Page 4'),
                  Icons.arrow_forward,
                ),
              ],
            ),
            translationRepository: mockTranslationRepository,
          ),
        ),
      ),
    ));

    // Assert
    expect(find.text('Page 1'), findsOneWidget);
    expect(find.text('Page 4'), findsNothing);

    // Act
    pageController.jumpToPage(3);

    // pump
    await tester.pumpAndSettle();

    // Assert
    expect(find.text('Page 1'), findsNothing);
    expect(find.text('Page 4'), findsOneWidget);

    // on click back button
    await tester.tap(find.byIcon(CustomIcons.arrow_left));

    // pump
    await tester.pumpAndSettle();

    // Assert
    expect(find.text('Page 3'), findsOneWidget);
  });

  testWidgets('Onboarding backbutton is not visible on first page',
      (WidgetTester tester) async {
    var mockTranslationRepository = MockTranslationRepository();

    var pageController = PageController();

    await tester.pumpWidget(MaterialApp(
      home: Localizations(
        delegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        locale: const Locale('nl'),
        child: Tokens(
          tokens: DefaultTokens(),
          child: Onboarding(
            viewModel: OnboardingViewModel(
              pageController: pageController,
              currentPage: 0,
              components: [
                OnboardingTestComponent(const Text('Page 1'), Icons.check),
                OnboardingTestComponent(
                    const Text('Page 2'), Icons.arrow_forward),
              ],
            ),
            translationRepository: mockTranslationRepository,
          ),
        ),
      ),
    ));

    await tester.pumpAndSettle();

    // Assert
    expect(find.byIcon(CustomIcons.arrow_left), findsNothing);
  });

  testWidgets('Onboarding backbutton is not visible on third page',
      (WidgetTester tester) async {
    var mockTranslationRepository = MockTranslationRepository();

    var pageController = PageController();

    await tester.pumpWidget(MaterialApp(
      home: Localizations(
        delegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        locale: const Locale('nl'),
        child: Tokens(
          tokens: DefaultTokens(),
          child: Onboarding(
            viewModel: OnboardingViewModel(
              pageController: pageController,
              currentPage: 2,
              components: [
                OnboardingTestComponent(const Text('Page 1'), Icons.check),
                OnboardingTestComponent(
                    const Text('Page 2'), Icons.arrow_forward),
                OnboardingTestComponent(
                    const Text('Page 3'), Icons.arrow_forward),
              ],
            ),
            translationRepository: mockTranslationRepository,
          ),
        ),
      ),
    ));

    await tester.pumpAndSettle();

    expect(find.byIcon(CustomIcons.arrow_left), findsNothing);
  });

  testWidgets('Onboarding backbutton is visible from fourth page',
      (WidgetTester tester) async {
    var mockTranslationRepository = MockTranslationRepository();

    var pageController = PageController();

    await tester.pumpWidget(MaterialApp(
      home: Localizations(
        delegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        locale: const Locale('nl'),
        child: Tokens(
          tokens: DefaultTokens(),
          child: Onboarding(
            viewModel: OnboardingViewModel(
              pageController: pageController,
              currentPage: 3,
              components: [
                OnboardingTestComponent(const Text('Page 1'), Icons.check),
                OnboardingTestComponent(
                    const Text('Page 2'), Icons.arrow_forward),
                OnboardingTestComponent(
                    const Text('Page 3'), Icons.arrow_forward),
                OnboardingTestComponent(
                  const Text('Page 4'),
                  Icons.arrow_forward,
                ),
              ],
            ),
            translationRepository: mockTranslationRepository,
          ),
        ),
      ),
    ));

    await tester.pumpAndSettle();

    expect(find.byIcon(CustomIcons.arrow_left), findsOneWidget);
  });

  // changing currentPage in didUpdateWidget unfocusses anything
  testWidgets('Onboarding unfocusses when changing currentPage',
      (WidgetTester tester) async {
    var mockTranslationRepository = MockTranslationRepository();

    var pageController = PageController();

    var viewModel = OnboardingViewModel(
      pageController: pageController,
      currentPage: 0,
      components: [
        OnboardingTestComponent(
            const Column(
              children: [
                Text('Page 1'),
                TextField(
                  autofocus: true,
                ),
              ],
            ),
            Icons.check),
        OnboardingTestComponent(const Text('Page 2'), Icons.arrow_forward),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Localizations(
          delegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          locale: const Locale('nl'),
          child: Tokens(
            tokens: DefaultTokens(),
            child: Onboarding(
              viewModel: viewModel,
              translationRepository: mockTranslationRepository,
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Act
    await tester.pumpWidget(MaterialApp(
      home: Localizations(
        delegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        locale: const Locale('nl'),
        child: Tokens(
          tokens: DefaultTokens(),
          child: Onboarding(
            viewModel: viewModel.copyWith(currentPage: 1),
            translationRepository: mockTranslationRepository,
          ),
        ),
      ),
    ));

    await tester.pumpAndSettle();

    expect(tester.binding.focusManager.primaryFocus?.debugLabel,
        'Navigator Scope');
  });
}
