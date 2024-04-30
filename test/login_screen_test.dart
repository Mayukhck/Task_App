import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_app/screens/login_screen.dart';

void main() {
  testWidgets('finding the title wedget', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    Finder title = find.text('Login Page');

    expect(title, findsOneWidget);
  });

  testWidgets('finding the emial id text field',
      (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    Finder emailTextFiled = find.byKey(const ValueKey('email_id'));

    expect(emailTextFiled, findsOneWidget);
  });

  testWidgets('finding the password id text field',
      (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    Finder passwordTextFiled = find.byKey(const ValueKey('pass'));

    expect(passwordTextFiled, findsOneWidget);
  });

  testWidgets('find buttons in the screen', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    Finder loginButton = find.byType(ElevatedButton);
    expect(loginButton, findsNWidgets(2));
  });

  testWidgets('should show required error meesage for empty field',
      (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    Finder loginButton = find.byKey(const ValueKey('login_button'));

    await widgetTester.tap(loginButton);
    await widgetTester.pumpAndSettle();

    Finder emailError = find.text('Please enter a valid email address');
    Finder passwordError = find.text('Password must be at least 6 characters');

    expect(emailError, findsOneWidget);
    expect(passwordError, findsOneWidget);
  });

  testWidgets(
      'should show required error mesage when email filed is empty and valied password',
      (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    Finder emailTextFiled = find.byKey(const ValueKey('email_id'));
    Finder passwordTextFiled = find.byKey(const ValueKey('pass'));

    await widgetTester.enterText(emailTextFiled, '');
    await widgetTester.enterText(passwordTextFiled, 'manu1234');

    Finder loginButton = find.byKey(const ValueKey('login_button'));

    await widgetTester.tap(loginButton);
    await widgetTester.pumpAndSettle();

    Finder emailError = find.text('Please enter a valid email address');

    expect(emailError, findsOneWidget);
  });

  testWidgets(
      'should show required error mesage when valied email and empty password',
      (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    Finder emailTextFiled = find.byKey(const ValueKey('email_id'));
    Finder passwordTextFiled = find.byKey(const ValueKey('pass'));

    await widgetTester.enterText(emailTextFiled, 'manu@gmail.com');
    await widgetTester.enterText(passwordTextFiled, '');

    Finder loginButton = find.byKey(const ValueKey('login_button'));

    await widgetTester.tap(loginButton);
    await widgetTester.pumpAndSettle();

    Finder passwordError = find.text('Password must be at least 6 characters');

    expect(passwordError, findsOneWidget);
  });

  testWidgets(
      'should show required error meesage for wrong email and password format',
      (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    Finder emailTextFiled = find.byKey(const ValueKey('email_id'));
    Finder passwordTextFiled = find.byKey(const ValueKey('pass'));

    await widgetTester.enterText(emailTextFiled, 'sdvregvds');
    await widgetTester.enterText(passwordTextFiled, 'pass');

    Finder loginButton = find.byKey(const ValueKey('login_button'));

    await widgetTester.tap(loginButton);
    await widgetTester.pumpAndSettle();

    Finder emailError = find.text('Please enter a valid email address');
    Finder passwordError = find.text('Password must be at least 6 characters');

    expect(emailError, findsOneWidget);
    expect(passwordError, findsOneWidget);
  });
}
