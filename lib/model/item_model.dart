import 'package:homework_flutter_application/enum/item_type.dart';

class ItemModel {
  final int id;
  final int value;
  final ItemType type;

  ItemModel({
    required this.id,
    required this.value,
    required this.type,
  });
}
