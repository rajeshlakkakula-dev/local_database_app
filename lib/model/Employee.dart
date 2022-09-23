
class Employee {
  late String firstName;
  late String lastName;
  late String mobileNo;
  late String emailId;

  Employee(this.firstName, this.lastName, this.mobileNo, this.emailId);

  Employee.fromMap(Map map) {
    firstName = map[firstName];
    lastName = map[lastName];
    mobileNo = map[mobileNo];
    emailId = map[emailId];
  }
}
