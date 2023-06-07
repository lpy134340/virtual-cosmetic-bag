
import 'package:beauty_habit_tracker/user_related/log_in.dart';
import 'package:beauty_habit_tracker/utils/button_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Log in page tests', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LogIn()));
    expect(find.text("Log in"), findsOneWidget);
    expect(find.text("We are happy to see you here :)"), findsOneWidget);
    expect(find.text('Continue with Email'), findsOneWidget);
    expect(find.text('Continue with Apple'), findsOneWidget);
    expect(find.text('Continue with Google'), findsOneWidget);
    expect(find.text('or'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);

    expect(find.byType(Divider), findsOneWidget);
    expect(find.byType(ProjectButton), findsWidgets);
    // todo: test page routing when tapping on the buttons
    expect(tester, meetsGuideline(textContrastGuideline));
    expect(tester, meetsGuideline(androidTapTargetGuideline));
  });
}