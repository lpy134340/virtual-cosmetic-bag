import 'package:beauty_habit_tracker/pre_login/pre_login_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Pre-login home tests', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MyHomePage()));
    expect(find.text("Welcome to Beauty Habit Tracker"), findsOneWidget);
    expect(find.text("We are happy to see you here :)"), findsOneWidget);
    expect(find.text("""
Track product expiration dates, be reminded with reflls, build your using habits and help save the environment. Want to learn more?"""),
        findsOneWidget);
    expect(find.text("Check out the video below"), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    // todo: test video player when on tap
    expect(find.byType(ElevatedButton), findsWidgets);
    expect(find.text("Log in"), findsOneWidget);
    expect(find.text("Sign up"), findsOneWidget);
    // todo: test page routing when tapping on the buttons
    expect(tester, meetsGuideline(textContrastGuideline));
    expect(tester, meetsGuideline(androidTapTargetGuideline));
  });
}
