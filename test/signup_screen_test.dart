import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_app/screens/signup_screen.dart';

void main() {
  testWidgets('finding the title wedget', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: SignUpScreen(),
    ));

    Finder title = find.text('Signup Page');

    expect(title, findsOneWidget);
  });

  testWidgets('finding the user name text field', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: SignUpScreen(),
    ));

    Finder userNameTextFiled = find.byKey(const ValueKey('User_name'));

    expect(userNameTextFiled, findsOneWidget);
  });

  testWidgets('finding the emial id text field', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: SignUpScreen(),
    ));

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

  testWidgets('should show required error meesage for empty field',
      (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: SignUpScreen(),
    ));

    Finder submitButton = find.byType(ElevatedButton);

    await widgetTester.tap(submitButton);
    await widgetTester.pumpAndSettle();

    Finder userError = find.text('Please enter a proper name');
    Finder emailError = find.text('Please enter a valied email address');
    Finder passwordError = find.text('Password atleast 6 charector');

    expect(userError, findsOneWidget);
    expect(emailError, findsOneWidget);
    expect(passwordError, findsOneWidget);
  });

  testWidgets(
      'should show required error mesage when user filed is empty with valied email and password',
      (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: SignUpScreen(),
    ));

    Finder userNameTextFiled = find.byKey(const ValueKey('User_name'));
    Finder emailTextFiled = find.byKey(const ValueKey('Email_id'));
    Finder passwordTextFiled = find.byKey(const ValueKey('password'));

    await widgetTester.enterText(userNameTextFiled, '');
    await widgetTester.enterText(emailTextFiled, 'manu@gmail.com');
    await widgetTester.enterText(passwordTextFiled, 'manu1234');

    Finder submitButton = find.byType(ElevatedButton);

    await widgetTester.tap(submitButton);
    await widgetTester.pumpAndSettle();

    Finder userError = find.text('Please enter a proper name');

    expect(userError, findsOneWidget);
  });

  testWidgets(
      'should show required error mesage when email filed is empty with valied user name and password',
      (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: SignUpScreen(),
    ));

    Finder userNameTextFiled = find.byKey(const ValueKey('User_name'));
    Finder emailTextFiled = find.byKey(const ValueKey('Email_id'));
    Finder passwordTextFiled = find.byKey(const ValueKey('password'));

    await widgetTester.enterText(userNameTextFiled, 'manu');
    await widgetTester.enterText(emailTextFiled, '');
    await widgetTester.enterText(passwordTextFiled, 'manu1234');

    Finder submitButton = find.byType(ElevatedButton);

    await widgetTester.tap(submitButton);
    await widgetTester.pumpAndSettle();

    Finder emailError = find.text('Please enter a valied email address');

    expect(emailError, findsOneWidget);
  });

  testWidgets(
      'should show required error mesage when password filed is empty with valied user name and email',
      (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: SignUpScreen(),
    ));

    Finder userNameTextFiled = find.byKey(const ValueKey('User_name'));
    Finder emailTextFiled = find.byKey(const ValueKey('Email_id'));
    Finder passwordTextFiled = find.byKey(const ValueKey('password'));

    await widgetTester.enterText(userNameTextFiled, 'manu');
    await widgetTester.enterText(emailTextFiled, 'manu@gmail.com');
    await widgetTester.enterText(passwordTextFiled, '');

    Finder submitButton = find.byType(ElevatedButton);

    await widgetTester.tap(submitButton);
    await widgetTester.pumpAndSettle();

    Finder passwordError = find.text('Password atleast 6 charector');

    expect(passwordError, findsOneWidget);
  });

  testWidgets(
      'should show required error meesage for wrong user name, email and password format',
      (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: SignUpScreen(),
    ));

    Finder userNameTextFiled = find.byKey(const ValueKey('User_name'));
    Finder emailTextFiled = find.byKey(const ValueKey('Email_id'));
    Finder passwordTextFiled = find.byKey(const ValueKey('password'));

    await widgetTester.enterText(userNameTextFiled, '');
    await widgetTester.enterText(emailTextFiled, 'manugmail.com');
    await widgetTester.enterText(passwordTextFiled, 'qw');

    Finder submitButton = find.byType(ElevatedButton);

    await widgetTester.tap(submitButton);
    await widgetTester.pumpAndSettle();

    Finder userError = find.text('Please enter a proper name');
    Finder emailError = find.text('Please enter a valied email address');
    Finder passwordError = find.text('Password atleast 6 charector');

    expect(userError, findsOneWidget);
    expect(emailError, findsOneWidget);
    expect(passwordError, findsOneWidget);
  });
}
