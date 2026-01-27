import 'item.dart';

enum Gender {
  male("Male"),
  female("Female");

  final String gender;

  const Gender(this.gender);
}

int? selectedItemId;
final List<Item> items = [
  Item(id: 1, title: Gender.male.gender),
  Item(id: 2, title: Gender.female.gender),
];
