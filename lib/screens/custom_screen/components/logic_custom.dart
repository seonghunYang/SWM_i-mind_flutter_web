import 'package:ai_counseling_platform/controllers/custom_logic_controller.dart';
import 'package:ai_counseling_platform/controllers/logic_custom_controller.dart';
import 'package:ai_counseling_platform/model/custom_indiactor_save.dart';
import 'package:ai_counseling_platform/model/logic_block.dart';
import 'package:ai_counseling_platform/screens/custom_screen/components/stepper_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:dotted_border/dotted_border.dart';

import '../../../constants.dart';

class LogicCustom extends StatelessWidget {
  const LogicCustom({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IndicatorName(index: index),
        SizedBox(
          height: defaultPadding * 3,
        ),
        Row(
          children: [
            SizedBox(
              width: defaultPadding * 4,
            ),
            Expanded(
              flex: 4,
              child: LogicBlockReorderableListView(),
            ),
            SizedBox(
              width: defaultPadding * 3,
            ),
            Expanded(
              flex: 6,
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  for (int idx = 0; idx < logicList.length; idx++)
                    Draggable(
                      data: logicList[idx].label,
                      child: StepperItem(
                        padding: EdgeInsets.all(defaultPadding * 0.5),
                        numberKey: idx,
                        text: logicList[idx].label,
                        currentNumberKey: -1,
                      ),
                      childWhenDragging: StepperItem(
                        numberKey: idx,
                        padding: EdgeInsets.all(defaultPadding * 0.5),
                        text: "",
                        currentNumberKey: -1,
                        inactiveColor: Colors.grey,
                      ),
                      feedback: StepperItem(
                        numberKey: idx,
                        padding: EdgeInsets.all(defaultPadding * 0.5),
                        text: logicList[idx].label,
                        currentNumberKey: -1,
                        inactiveColor: kContainerColor.withOpacity(0.5),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: defaultPadding * 4,
            ),
          ],
        ),
        SizedBox(
          height: defaultPadding * 12,
        ),
      ],
    );
  }
}

class LogicBlockReorderableListView extends StatefulWidget {
  const LogicBlockReorderableListView({
    Key? key,
  }) : super(key: key);

  @override
  State<LogicBlockReorderableListView> createState() =>
      _LogicBlockReorderableListViewState();
}

class _LogicBlockReorderableListViewState
    extends State<LogicBlockReorderableListView> {
  CustomLogicController customLogicController = CustomLogicController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReorderableListView(
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
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
                        setState(() {});
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
            onReorder: (oldIndex, newIndex) {
              setState(() {
                customLogicController.reOrderLogic(oldIndex, newIndex);
              });
            }),
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
            final LogicBlock logicBlock = LogicBlock(label: data, value: data);
            customLogicController.addLogic(logicBlock);
            setState(() {});
          },
        ),
      ],
    );
  }
}

class IndicatorName extends StatefulWidget {
  const IndicatorName({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  State<IndicatorName> createState() => _IndicatorNameState();
}

class _IndicatorNameState extends State<IndicatorName> {
  @override
  Widget build(BuildContext context) {
    final LogicCustomController logicCustomController =
        context.watch<LogicCustomController>();
    CustomIndicatorSave indicatorSave =
        logicCustomController.customDbList[widget.index];
    return Container(
      width: 150,
      height: 60,
      child: !indicatorSave.isFinished
          ? TextField(
              onEditingComplete: () {
                logicCustomController.updateFinishedControl(widget.index);
              },
              onChanged: (newValue) {
                logicCustomController.updateIndicatorName(
                    widget.index, newValue);
              },
              decoration: InputDecoration(
                hintText: "지표이름",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: defaultPadding * 1.75),
              ),
            )
          : Text(
              "지표: ${indicatorSave.indicatorName}",
              style: Theme.of(context).textTheme.headline4,
            ),
    );
  }
}
