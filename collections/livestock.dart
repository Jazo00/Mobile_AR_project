import 'package:isar/isar.dart';

part 'livestock.g.dart';

@Collection()
class Livestock {
  Id id = Isar.autoIncrement;

  late String type;
  late int age;
  late String sex;
  late String breed;
  late String farmerName;
  late DateTime dateListed;
}
