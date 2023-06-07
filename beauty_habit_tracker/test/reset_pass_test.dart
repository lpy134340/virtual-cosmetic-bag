import 'package:beauty_habit_tracker/user_related/reset_password.dart';
import 'package:beauty_habit_tracker/utils/button_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Reset password tests', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ResetPassword()));
    expect(find.text("Reset password"), findsOneWidget);
    expect(find.text("Please enter your email address. A message will be sent with instructions to reset your password"), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text("Submit"), findsOneWidget);

    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.byType(ProjectButton), findsWidgets);

    expect(tester, meetsGuideline(textContrastGuideline));
    expect(tester, meetsGuideline(androidTapTargetGuideline));
    
    // todo: test page routing when tapping on the buttons
    // user authentication and when there are errors
  });
}