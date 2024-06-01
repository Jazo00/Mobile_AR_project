import 'package:isar/isar.dart';

part 'user_customer.g.dart';

@Collection()
class UserCustomer {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String username;

  @Index(unique: true)
  late String email;

  late String password;

  @Index(unique: true)
  late String phoneNumber;
  
  late String userType;
}
