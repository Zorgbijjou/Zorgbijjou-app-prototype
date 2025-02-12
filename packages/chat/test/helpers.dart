import 'package:flutter/material.dart';
import 'package:theme/assets/tokens/tokens.g.dart';

materialAppWithTokens({required Widget child, ITokens? tokens}) {
  return MaterialApp(
    home: Tokens(tokens: tokens ?? DefaultTokens(), child: child),
  );
}
