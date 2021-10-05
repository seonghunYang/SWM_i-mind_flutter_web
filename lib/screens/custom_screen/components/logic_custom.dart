import 'package:ai_counseling_platform/controllers/custom_logic_controller.dart';
import 'package:ai_counseling_platform/model/logic_block.dart';
import 'package:ai_counseling_platform/screens/custom_screen/components/stepper_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:dotted_border/dotted_border.dart';

import '../../../constants.dart';

class LogicCustom extends StatelessWidget {
  const LogicCustom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomLogicController customLogicController =
        context.watch<CustomLogicController>();
    return Row(
      children: [
        Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              ReorderableListView(
                  header: Padding(
                    padding: const EdgeInsets.only(bottom: defaultPadding * 2),
                    child: Text(
                      "커스텀 로직",
                      style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding * 2),
                  buildDefaultDragHandles: false,
                  shrinkWrap: true,
                  children: [
                    for (int idx = 0;
                        idx < customLogicController.selectedLogicList.length;
                        idx++)
                      Container(
                        key: Key('$idx'),
                        margin: const EdgeInsets.symmetric(
                          vertical: defaultPadding * 0.5,
                        ),
                        decoration: const BoxDecoration(
                            color: kSelectedContainerColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        height: 50,
                        alignment: Alignment.center,
                        child: ListTile(
                          title: Text(
                            "${customLogicController.selectedLogicList[idx].label}",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          horizontalTitleGap: 0.5,
                          leading: ReorderableDragStartListener(
                            index: idx,
                            child: const Icon(
                              Icons.drag_handle,
                              color: Colors.white,
                            ),
                          ),
                          trailing: InkWell(
                            onTap: () {
                              customLogicController.removeLogic(idx);
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                  ],
                  onReorder: customLogicController.reOrderLogic),
              DragTarget(
                builder: (context, _, __) => Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 2,
                    vertical: defaultPadding * 0.5,
                  ),
                  child: DottedBorder(
                    dashPattern: [6, 3],
                    borderType: BorderType.RRect,
                    radius: Radius.circular(10.0),
                    strokeWidth: 3.0,
                    color: kContainerColor,
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: kContainerColor.withOpacity(0.5),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Icon(
                        Icons.add,
                        size: 30.0,
                        color: kSelectedContainerColor,
                      ),
                    ),
                  ),
                ),
                onAccept: (String data) {
                  final LogicBlock logicBlock =
                      LogicBlock(label: data, value: data);
                  customLogicController.addLogic(logicBlock);
                },
              )
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: Wrap(
            spacing: 12,
            alignment: WrapAlignment.center,
            children: [
              for (int idx = 0; idx < logicList.length; idx++)
                Draggable(
                  data: logicList[idx].label,
                  child: StepperItem(
                    width: 150,
                    numberKey: idx,
                    text: logicList[idx].label,
                    currentNumberKey: -1,
                  ),
                  childWhenDragging: StepperItem(
                    width: 150,
                    numberKey: idx,
                    text: "",
                    currentNumberKey: -1,
                    inactiveColor: Colors.grey,
                  ),
                  feedback: StepperItem(
                    width: 160,
                    numberKey: idx,
                    text: logicList[idx].label,
                    currentNumberKey: -1,
                    inactiveColor: kContainerColor.withOpacity(0.5),
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}
