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

  testWidgets('finding the emial id text field',
      (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    Finder passwordTextFiled = find.byKey(const ValueKey('pass'));

    expect(passwordTextFiled, findsOneWidget);
  });

  testWidgets('find button in the screen', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    Finder loginButton = find.byType(ElevatedButton);
    expect(loginButton, findsNWidgets(2));
  });
}
