import 'package:local_database_app/model/Employee.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {


  static late Database database;

  Future<Database> get db async {
    database = await initDb();

    return database;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), 'employee.db');

    final theDb = openDatabase(path, onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE employee(id INTEGER PRIMARY KEY,firstName TEXT, lastName TEXT, mobileNo INTEGER, emailId TEXT)',
      );
    }, version: 1);
    return theDb;
  }

  saveEmployee(Employee employee) async {
    var dbClient = await db;

    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO employee(firstName,lastName,mobileNo,emailId) VALUES(' +
              '\'' +
              employee.firstName +
              '\'' +
              ',' +
              '\'' +
              employee.lastName +
              '\'' +
              ',' +
              '\'' +
              employee.mobileNo +
              '\'' +
              ',' +
              '\'' +
              employee.emailId +
              '\'' +
              ')');
    });
    print("save Employee Data");
  }

  Future<List<Employee>> getEmployees() async {
    var dbClient = await db;

    List<Map> list = await dbClient.rawQuery('SELECT * from employee');

    List<Employee> employees = [];

    for (int i = 0; i < employees.length; i++) {
      employees.add(Employee(list[i]["firstName"], list[i]["lastName"],
          list[i]["mobileNo"], list[i]["emailId"]));
    }

    print(employees.length);
    return employees;
  }
}
