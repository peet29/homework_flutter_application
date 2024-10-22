import 'package:homework_flutter_application/enum/item_type.dart';
import 'package:homework_flutter_application/model/item_model.dart';

class MainController {
  final List<ItemModel> mainList = [];
  final List<ItemModel> bottomSheetList = [];
  int? addedBottomSheetId;
  int? addedMainId;

  void generateItems(int size) {
    int lastValue = 0;
    int nextValue = 1;
    for (int i = 0; i < size; i++) {
      mainList.add(
        ItemModel(
          id: i,
          value: lastValue,
          type: ItemType.values[i % ItemType.values.length],
        ),
      );
      int next = lastValue + nextValue;
      lastValue = nextValue;
      nextValue = next;
    }
  }

  void tapOnMainList(int index) {
    final mainItem = mainList[index];
    bottomSheetList.add(mainList[index]);
    bottomSheetList.sort((a, b) => a.value.compareTo(b.value));
    addedBottomSheetId = mainItem.id;
    mainList.removeAt(index);
    mainList.sort((a, b) => a.value.compareTo(b.value));
  }

  void tapOnBottomSheetList(int index) {
    final list = getBottomSheetItem();
    final bottomSheetItem = list[index];
    mainList.add(bottomSheetItem);
    mainList.sort((a, b) => a.value.compareTo(b.value));
    addedMainId = bottomSheetItem.id;

    bottomSheetList.removeWhere((element) => element.id == bottomSheetItem.id);
    bottomSheetList.sort((a, b) => a.value.compareTo(b.value));
  }

  List<ItemModel> getBottomSheetItem() {
    final id = addedBottomSheetId;
    if (id != null) {
      final bottomSheetItem =
          bottomSheetList.firstWhere((item) => item.id == id);
      return getItemByType(bottomSheetItem.type);
    }

    return [];
  }

  List<ItemModel> getItemByType(ItemType type) {
    return bottomSheetList.where((element) => element.type == type).toList()
      ..sort((a, b) => a.value.compareTo(b.value));
  }

  int get getAddedMainItemIndex {
    return mainList.indexWhere((element) => element.id == addedMainId);
  }
}
