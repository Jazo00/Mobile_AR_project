import 'package:isar/isar.dart';

part 'user_seller.g.dart';

@Collection()
class UserSeller {
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

