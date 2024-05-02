import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:task_app/data/user_data.dart';

import 'dummy_data_test.mocks.dart';
void sqfliteTestInit() {
  // Initialize ffi implementation
  sqfliteFfiInit();
  // Set global factory
  databaseFactory = databaseFactoryFfi;
}

@GenerateMocks([DatabaseHelper])
Future main() async {
  sqfliteFfiInit();
  group('Data base test', () {
    test('sqflite version', () async {
      final db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
      await db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, username TEXT, email TEXT, password TEXT)');

      final mockDbHelper = MockDatabaseHelper();
      when(mockDbHelper.db).thenAnswer((realInvocation) => db);

      final activityItemHelper = DatabaseHelper();

      final newUser = User(
          username: 'tester',
          email: 'tester@gmail.com',
          password: 'tester1234');

      activityItemHelper.insertUser(newUser);

      final query = await db.query('users');
      expect(query.length, 1);
      await db.close();
    });
  });
}
