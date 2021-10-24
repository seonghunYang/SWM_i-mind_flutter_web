import 'package:ai_counseling_platform/controllers/chips_controller.dart';
import 'package:ai_counseling_platform/screens/custom_screen/components/stepper_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:group_button/group_button.dart';

import '../../../constants.dart';

class ActionLabelWrap extends StatelessWidget {
  const ActionLabelWrap({
    Key? key,
    required this.labelList,
    required this.onSelected,
  }) : super(key: key);

  final List<String> labelList;
  final void Function(int, bool) onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Consumer<ChipsController>(builder: (context, chipsController, __) {
        return GroupButton(
          // selectedTextStyle: TextStyle(),
          groupRunAlignment: GroupRunAlignment.start,
          mainGroupAlignment: MainGroupAlignment.start,
          isRadio: false,
          spacing: 20,
          runSpacing: 10,
          onSelected: onSelected,
          buttons: labelList,
          textPadding: EdgeInsets.zero,
          selectedColor: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(defaultPadding * 0.5)),
        );

        //   Wrap(
        //   alignment: WrapAlignment.center,
        //   spacing: 12,
        //   runSpacing: 12,
        //   children: labels
        //       .map(
        //         (item) => Row(
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             InkWell(
        //               onTap: () {
        //                 int index = labels.indexOf(item);
        //                 if (chipsController.selectedNumberKeyList
        //                     .contains(index)) {
        //                   chipsController.removeSelectedNumberKeyList(index);
        //                 } else {
        //                   chipsController.updateSelectedNumberKeyList(index);
        //                 }
        //               },
        //               child: StepperItem(
        //                 text: item,
        //                 fontSize: 11,
        //                 numberKey: labels.indexOf(item),
        //                 selectedNumberKeyList:
        //                     chipsController.selectedNumberKeyList,
        //                 padding: const EdgeInsets.symmetric(
        //                     horizontal: defaultPadding * 1,
        //                     vertical: defaultPadding * 0.5),
        //               ),
        //             ),
        //           ],
        //         ),
        //       )
        //       .toList(),
        // );
      }),
    );
  }
}
