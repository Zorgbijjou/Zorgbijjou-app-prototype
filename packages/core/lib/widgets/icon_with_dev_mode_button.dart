import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

class ZbjIconWithDevModeButton extends StatefulWidget {
  final Widget icon;
  final bool devModeEnabled;
  final VoidCallback onDevModeEnabled;
  final VoidCallback onDevButtonClick;

  const ZbjIconWithDevModeButton({
    super.key,
    required this.icon,
    required this.devModeEnabled,
    required this.onDevModeEnabled,
    required this.onDevButtonClick,
  });

  @override
  ZbjIconWithDevModeButtonState createState() =>
      ZbjIconWithDevModeButtonState();
}

class ZbjIconWithDevModeButtonState extends State<ZbjIconWithDevModeButton> {
  int _clickCount = 0;
  DateTime? _firstClickTime;

  void _handleIconClick() {
    var now = DateTime.now();
    if (_firstClickTime == null ||
        now.difference(_firstClickTime!) > const Duration(seconds: 2)) {
      _firstClickTime = now;
      _clickCount = 1;
    } else {
      _clickCount++;
    }

    if (_clickCount >= 5) {
      widget.onDevModeEnabled();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleIconClick,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          widget.icon,
          if (widget.devModeEnabled)
            Container(
              width: 30,
              height: 20,
              alignment: Alignment.center,
              child: ElevatedButton(
                // no padding

                style: ButtonStyle(
                  padding: WidgetStateProperty.all(EdgeInsets.zero),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor: WidgetStateProperty.all(
                    context.tokens.color.tokensRed600,
                  ),
                ),
                onPressed: widget.onDevButtonClick,
                child: Text(
                  'DEV',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: context.tokens.color.tokensWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
