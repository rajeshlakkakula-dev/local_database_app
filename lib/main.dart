import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:local_database_app/Database/DBHelper.dart';
import 'package:local_database_app/model/Employee.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Data',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  Employee employee = Employee("", "", "", "");

  late String firstName;
  late String lastName;
  late String mobileNo;
  late String emailId;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Form'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.view_list))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(labelText: 'FirstName'),
                validator: (val) => val?.length == 0 ? "Enter FirstName" : null,
                onSaved: (val) => firstName = val!,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(labelText: 'LastName'),
                validator: (val) => val?.length == 0 ? "Enter LastName" : null,
                onSaved: (val) => lastName = val!,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'mobileNo'),
                validator: (val) => val?.length == 0 ? "Enter mobileNo" : null,
                onSaved: (val) => mobileNo = val!,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email Address'),
                validator: (val) => val?.length == 0 ? "Enter emailId" : null,
                onSaved: (val) => emailId = val!,
              ),
              Container(
                child: ElevatedButton(
                  onPressed: submit,
                  child: Text('Submit'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
    } else {
      return null;
    }

    var employee = Employee(firstName, lastName, mobileNo, emailId);

    var dbHelper = DBHelper();

    dbHelper.saveEmployee(employee);

    showSnackBar("Data Save Successfully");
  }

  void showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
