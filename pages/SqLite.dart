import 'package:medicine/Json Models/addMedicine.dart';
import 'package:medicine/Json Models/users.dart';
import 'package:medicine/pages/addMed.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper {
  String databaseName = 'My_Therapy.db';

  String user =
      'CREATE TABLE Users (userId INTEGER PRIMARY KEY, userName TEXT UNIQUE, password TEXT UNIQUE)';
  String medicine =
      'CREATE TABLE Medicines (id INTEGER PRIMARY KEY, form TEXT, name TEXT, expiry TEXT, amount INTEGER)';


// initializing the database functionality in the app
 Future<Database> initDatabase() async {
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, databaseName);

  return openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      try {
        await db.execute(user);
        await db.execute(medicine);

        print("Tables created successfully!");
      } catch (e) {
        print("Error during table creation: $e");
      }
    },
  );
}

  Future<bool> login(User user) async {
    final Database db = await initDatabase();
    var results = await db.rawQuery(
      "SELECT * FROM Users WHERE userName = '${user.userName}' AND Password = '${user.password}'",
    );

    return results.isNotEmpty;
  }

  Future<int> signup(User user) async {
    final Database db = await initDatabase();
    try {
      return await db.insert(
        'Users',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("Error during signup: $e");
      return -1;
    }
  }

  Future<User?> getUser(String userName) async {
    final Database db = await initDatabase();
    var response = await db.query("Users", where: "userName=?", whereArgs: [userName]);
    return response.isNotEmpty ? User.fromMap(response.first) : null;
  }

  // Function for adding medication
  Future<void> addMedication(Empty medicine) async {
    final Database db = await initDatabase();
    await db.insert(
      'Medicines',
      medicine.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Function to get all medications
 Future<List<Empty>> getAllMedications() async {
  final Database db = await initDatabase();
  final List<Map<String, dynamic>> maps = await db.query(
    'Medicines',
    columns: ['form', 'name', 'expiry', 'amount'],
  );

  return List.generate(
    maps.length,
    (index) {
      return Empty(
        form: maps[index]['form'],
        name: maps[index]['name'],
        expiry: maps[index]['expiry'],
        amount: maps[index]['amount'],
      );
    },
  );
}
}


// funtion for updating passwords
/* Future<int> updatePassword(String userName, String newPassword) async {
   final Database db = await initDatabase();
    return await db.update(
      'Users',
      {'password': newPassword},
      where: 'userName = ?',
      whereArgs: [userName],
    );
  }*/


