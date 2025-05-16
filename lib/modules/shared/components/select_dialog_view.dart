import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

typedef DialogItemBuilder = Widget Function(BuildContext context, int index);
typedef DialogItemTapCallback = void Function(int index);
typedef SelectChurchHandler = void Function(int index, String selectedName, String parishlink);
typedef SelectPriestHandler = void Function(int index, bool isAll);

abstract class CustomSelectionDialog extends StatelessWidget {
  final String title;
  final int itemCount;
  final DialogItemBuilder itemBuilder;
  final DialogItemTapCallback onItemTap;

  const CustomSelectionDialog({
    Key? key,
    required this.title,
    required this.itemCount,
    required this.itemBuilder,
    required this.onItemTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      contentPadding: const EdgeInsets.all(0),
      title: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color.fromRGBO(4, 26, 82, 1),
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
              RawMaterialButton(
                constraints: const BoxConstraints(),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: () => Navigator.pop(context),
                shape: const CircleBorder(),
                child: const SizedBox(
                  width: 24,
                  height: 24,
                  child: Icon(
                    MaterialCommunityIcons.close_circle,
                    color: Color.fromRGBO(130, 141, 168, 1),
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width * 0.7,
        child: ListView.separated(
          itemCount: itemCount,
          separatorBuilder: (BuildContext context, int index) {
            return Container();
          },
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                onItemTap(index);
                Navigator.pop(context);
              },
              child: itemBuilder(context, index),
            );
          },
        ),
      ),
    );
  }

  static Widget _dialogItem(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          name,
          style: const TextStyle(
            color: Color.fromRGBO(4, 26, 82, 1),
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class SelectChurchDialog extends CustomSelectionDialog {
  static const String dialogTitle = 'Select Church';

  SelectChurchDialog({
    Key? key,
    required List<dynamic> churchList,
    required SelectChurchHandler onSelected,
    required BuildContext context,
  }) : super(
    key: key,
    title: dialogTitle,
    itemCount: churchList.length,
    itemBuilder: (context, index) {
      final name = churchList[index]['name'] ?? '';
      return CustomSelectionDialog._dialogItem(name);
    },
    onItemTap: (index) {
      String name = churchList[index]['name']?.toString() ?? '';
      String parishlink = churchList[index]['link'].toString();
      if (name == 'All Churches') {
        name = 'all';
        parishlink = 'all';
      }
      onSelected(index, name, parishlink);
    },
  );
}

class SelectPriestDialog extends CustomSelectionDialog {
  SelectPriestDialog({
    Key? key,
    required List<Map<dynamic, dynamic>> priestList,
    required SelectPriestHandler onSelected,
  }) : super(
      key: key,
      title: 'Select Priest',
      itemCount: priestList.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSelectionDialog._dialogItem('All Priests'),
              CustomSelectionDialog._dialogItem(_formatPriest(priestList[index])),
            ],
          );
        }

        return CustomSelectionDialog._dialogItem(_formatPriest(priestList[index]));
      },
      onItemTap: (index) {
        bool isAll = index == 0;
        onSelected(index, isAll);
      },
    );

  static String _formatPriest(Map<dynamic, dynamic> priest) {
    final salutation = priest['salutation'] ?? '';
    final name = priest['name'] ?? '';
    final suffix = (priest['suffix'] ?? '').toString();
    return '$salutation $name${suffix.isNotEmpty ? ', $suffix' : ''}';
  }
}
