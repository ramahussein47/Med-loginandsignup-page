/*import 'dart:async';

import 'package:flutter/widgets.dart';

Future<Database>()async{
  WidgetsFlutterBinding.ensureInitialized();
// Open the database and store the reference.
final Database = openDatabase(
  // Set the path to the database. Note: Using the `join` function from the
  // `path` package is best practice to ensure the path is correctly
  // constructed for each platform.
  join(await getDatabasesPath(), 'Users.db'),

  onCreate: (db, version) {
    // Run the CREATE TABLE statement on the database.
    return db.execute(
      'CREATE TABLE dogs(id INTEGER PRIMARY KEY, username TEXT, password TEXT)',
    );
  },
  // Set the version. This executes the onCreate function and provides a
  // path to perform database upgrades and downgrades.
  version: 1,
);


}*/
