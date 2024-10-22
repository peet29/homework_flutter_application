import 'package:flutter/material.dart';
import 'package:homework_flutter_application/controller/main_controller.dart';
import 'package:homework_flutter_application/enum/item_type.dart';

class FibonacciList extends StatefulWidget {
  final MainController controller;
  const FibonacciList({super.key, required this.controller});

  @override
  FibonacciListState createState() => FibonacciListState();
}

class FibonacciListState extends State<FibonacciList> {
  final itemScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: itemScrollController,
      itemCount: widget.controller.mainList.length,
      itemBuilder: (context, index) {
        final item = widget.controller.mainList[index];

        final title = 'index: $index Number: ${item.value}';

        final isSelected = item.id == widget.controller.addedMainId;

        return ListTile(
          title: Text(title),
          tileColor: isSelected ? Colors.red : null,
          trailing: icon(item.type),
          onTap: () async {
            setState(() {
              widget.controller.tapOnMainList(index);
            });

            final list = widget.controller.getBottomSheetItem();

            await showModalBottomSheet(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                ),
                context: context,
                builder: (context) {
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final item = list[index];
                      final title = 'index: $index Number: ${item.value}';
                      final isSelected =
                          item.id == widget.controller.addedBottomSheetId;

                      return ListTile(
                        tileColor: isSelected ? Colors.green : null,
                        title: Text(title),
                        onTap: () {
                          setState(() {
                            widget.controller.tapOnBottomSheetList(index);
                          });
                          Navigator.pop(
                            context,
                          );
                        },
                        trailing: icon(item.type),
                      );
                    },
                  );
                });
            if (widget.controller.addedMainId != null) {
              setState(() {
                scrollToItem(widget.controller.getAddedMainItemIndex);
              });
            }
          },
        );
      },
    );
  }

  Widget icon(ItemType type) {
    switch (type) {
      case ItemType.square:
        return const Icon(Icons.square);
      case ItemType.cross:
        return const Icon(Icons.close);
      case ItemType.circle:
        return const Icon(Icons.circle);
    }
  }

  void scrollToItem(int index) {
    itemScrollController.animateTo(
      index * 50.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
