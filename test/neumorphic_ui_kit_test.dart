import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:neumorphic_ui_kit/neumorphic_ui_kit.dart';

void main() {
  group('NeumorphicContainer Tests', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        NeumorphicTheme(
          theme: NeumorphicThemeData.light(),
          child: const NeumorphicContainer(
            width: 100,
            height: 100,
            child: SizedBox(),
          ),
        ),
      );

      expect(find.byType(NeumorphicContainer), findsOneWidget);
    });
  });
}
