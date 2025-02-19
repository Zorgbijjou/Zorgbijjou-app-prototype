import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:theme/assets/icons/custom_icons.dart';
import 'package:theme/assets/tokens/grid_extensions.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

import '../view_models/onboarding_view_model.dart';

class Onboarding extends StatefulWidget {
  final TranslationRepository translationRepository;
  final OnboardingViewModel viewModel;

  const Onboarding({
    super.key,
    required this.viewModel,
    required this.translationRepository,
  });

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  double _pageViewContentHeight = 0;

  var bottomBarHeight = 80.0;
  var backButtonHeight = 96.0;

  @override
  void didUpdateWidget(covariant Onboarding oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.viewModel.currentPage != widget.viewModel.currentPage) {
      FocusScope.of(context).unfocus();
    }
  }

  void _updatePageViewContentSize(Size size) {
    setState(() {
      _pageViewContentHeight = size.height;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool landscapeMode =
        MediaQuery.orientationOf(context) == Orientation.landscape;

    bool tabletMode = context.isTabletView();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'packages/onboarding/assets/images/onboarding-background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.only(
              left: getSidePadding(tabletMode, landscapeMode),
              right: getSidePadding(tabletMode, landscapeMode),
              bottom: tabletMode ? 32 : 0,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) => ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: constraints.maxHeight,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: tabletMode
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.spaceBetween,
                  children: [
                    buildBackButton(tabletMode),
                    Container(
                      decoration: BoxDecoration(
                        color: context.tokens.color.tokensWhite,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(24.0),
                          topRight: const Radius.circular(24.0),
                          bottomLeft: Radius.circular(tabletMode ? 24 : 0),
                          bottomRight: Radius.circular(tabletMode ? 24 : 0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.24),
                            offset: const Offset(2, 2),
                            blurRadius: 8.0,
                          ),
                        ],
                      ),
                      child: SafeArea(
                        top: false,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            buildOnboardingPageView(
                              maxHeight: constraints.maxHeight -
                                  backButtonHeight -
                                  bottomBarHeight,
                            ),
                            buildBottomBar(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBackButton(bool tabletMode) {
    return Container(
      height: backButtonHeight,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(
        left: tabletMode ? 0.0 : 24.0,
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: widget.viewModel.isBackButtonActive
            ? ZbjIconButton.secondary(
                key: const ValueKey('backButton'),
                onPressed: _onBackButtonClicked,
                icon: const Icon(CustomIcons.arrow_left),
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  _onBackButtonClicked() {
    if (!widget.viewModel.isBackButtonActive) {
      return;
    }

    widget.viewModel.pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Widget buildOnboardingPageView({required double maxHeight}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _pageViewContentHeight,
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: widget.viewModel.pageController,
        children: [
          for (var component in widget.viewModel.components)
            SingleChildScrollView(
              child: _MeasureSize(
                onChange: _updatePageViewContentSize,
                child: component,
              ),
            ),
        ],
      ),
    );
  }

  Widget buildBottomBar() {
    return Container(
      height: bottomBarHeight,
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
      ),
      child: Builder(
        builder: (context) {
          if (widget.viewModel.components.isEmpty) {
            return const SizedBox.shrink();
          }

          var currentStep = widget.viewModel.currentPage + 1;
          var totalSteps = widget.viewModel.components.length;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatusBar(
                pageController: widget.viewModel.pageController,
                steps: totalSteps,
                step: currentStep,
              ),
              Builder(builder: (context) {
                var currentComponentState = widget
                    .viewModel.componentForCurrentPage.globalKey.currentState;

                if (currentComponentState is OnboardingComponentState) {
                  return currentComponentState.buildActionButton(context);
                } else {
                  return const SizedBox(height: 48);
                }
              }),
            ],
          );
        },
      ),
    );
  }

  double getSidePadding(
    bool tabletMode,
    bool landscapeMode,
  ) {
    var mobilePortrait = 0.0;
    var mobileLandscape = 159.0;
    var tabletPortrait = 153.0;
    var tabletLandscape = 217.0;

    if (tabletMode && landscapeMode) {
      return tabletLandscape;
    }

    if (tabletMode) {
      return tabletPortrait;
    }

    if (landscapeMode) {
      return mobileLandscape;
    }

    return mobilePortrait;
  }
}

typedef _SizeCallback = void Function(Size size);

class _MeasureSizeRenderObject extends RenderProxyBox {
  _SizeCallback onChange;
  Size? oldSize;

  _MeasureSizeRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();
    Size newSize = child?.size ?? Size.zero;
    if (oldSize == newSize) return;

    oldSize = newSize;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}

class _MeasureSize extends SingleChildRenderObjectWidget {
  final _SizeCallback onChange;

  const _MeasureSize({
    required this.onChange,
    required Widget child,
  }) : super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _MeasureSizeRenderObject(onChange);
  }
}
