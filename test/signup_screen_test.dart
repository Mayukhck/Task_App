import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_app/screens/signup_screen.dart';

void main(){
  testWidgets('finding the title wedget', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(home: SignUpScreen(),));

    Finder title = find.text('Signup Page');

    expect(title, findsOneWidget);
  });

  testWidgets('finding the emial id text field', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(home: SignUpScreen(),));

    Finder emailTextFiled = find.byKey(const ValueKey('Email_id'));

    expect(emailTextFiled, findsOneWidget);
  });

  testWidgets('finding the password id text field',
      (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: SignUpScreen(),
    ));

    Finder passwordTextFiled = find.byKey(const ValueKey('password'));

    expect(passwordTextFiled, findsOneWidget);
  });

   testWidgets('find buttons in the screen', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: SignUpScreen(),
    ));

    Finder submitButton = find.byType(ElevatedButton);
    expect(submitButton, findsOneWidget);
  });
}