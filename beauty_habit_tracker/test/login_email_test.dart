import 'package:beauty_habit_tracker/user_related/log_in_email.dart';
import 'package:beauty_habit_tracker/utils/button_factory.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Login via email tests', (WidgetTester tester) async {
    expect(tester, meetsGuideline(textContrastGuideline));
    expect(tester, meetsGuideline(androidTapTargetGuideline));
    /*
    FlutterError.onError = ignoreOverflowErrors;
    await tester.pumpWidget(const MaterialApp(home: LogInEmail()));
    expect(find.text("Log in"), findsOneWidget);
    expect(find.text("We are happy to see you here :)"), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text("Forget your password?"), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text('Submit'), findsOneWidget);
    expect(find.text('Reset'), findsOneWidget);

    //expect(find.byType(SizedBox), findsOneWidget);
    expect(find.byType(TextFormField), findsWidgets);
    expect(find.byType(ProjectButton), findsWidgets);

    // tap and finds the snack bar

    // todo: test page routing when tapping on the buttons
    // user authentication and when there are errors

    // semantics testing
    expect(
      find.bySemanticsLabel("Log in"),
      findsOneWidget,
    );

    expect(
      find.bySemanticsLabel('We are happy to see your here :)'),
      findsOneWidget,
    );

    expect(
      find.bySemanticsLabel("Forget your password?"),
      findsOneWidget,
    );

    expect(
      find.bySemanticsLabel('Reset password'),
      findsOneWidget,
    );

    expect(
      find.bySemanticsLabel('Cancel'),
      findsOneWidget,
    );

    expect(
      find.bySemanticsLabel('Submit'),
      findsOneWidget,
    );
    */
  });
}
