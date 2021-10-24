import 'package:flutter/material.dart';
// class GrowthIndicatorCard extends StatelessWidget {
//   const GrowthIndicatorCard({
//     Key? key,
//     required this.info,
//   }) : super(key: key);
//
//   final GrowthIndicatorInfo info;
//
//   @override
//   Widget build(BuildContext context) {
//     // final palette = context.watch<PaletteController>().palette;
//     return Container(
//       padding: EdgeInsets.all(defaultPadding),
//       decoration: BoxDecoration(
//         color: Colors.black,
//         borderRadius: BorderRadius.all(
//           Radius.circular(10),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 padding: EdgeInsets.all(defaultPadding * 0.75),
//                 height: 40,
//                 width: 40,
//                 decoration: BoxDecoration(
//                   color: info.color.withOpacity(0.1),
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10.0),
//                   ),
//                 ),
//                 child: SvgPicture.asset(
//                   info.svgSrc,
//                   // color: info.color,
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {},
//                 child: Row(
//                   children: [
//                     Text(
//                       "자세히 보기",
//                       style: TextStyle(
//                         fontSize: 12,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 1,
//                     ),
//                     Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       size: 8,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Text(
//             info.title,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: TextStyle(
//               fontSize: 15,
//             ),
//           ),
//           GrowthProgressCard(info: info),
//         ],
//       ),
//     );
//   }
// }
//
// class ResultExpansionPanel extends StatefulWidget {
//   const ResultExpansionPanel({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   _ResultExpansionPanelState createState() => _ResultExpansionPanelState();
// }
//
// class _ResultExpansionPanelState extends State<ResultExpansionPanel> {
//   List<bool> _isOpen = [false];
//
//   @override
//   Widget build(BuildContext context) {
//     return ExpansionPanelList(
//       elevation: 0,
//       children: [
//         ExpansionPanel(
//           isExpanded: _isOpen[0],
//           headerBuilder: (context, isExpanded) {
//             return ListTile(
//               title: Text("asd"),
//             );
//           },
//           body: ListTile(
//             title: Text("asdasd"),
//           ),
//         ),
//       ],
//       expansionCallback: (index, isOpen) {
//         setState(() {
//           _isOpen[index] = !isOpen;
//         });
//       },
//     );
//   }
// }
//
// class GrowthProgressCard extends StatelessWidget {
//   GrowthProgressCard({
//     Key? key,
//     required this.info,
//   }) : super(key: key);
//
//   final GrowthIndicatorInfo info;
//
//   @override
//   Widget build(BuildContext context) {
//     final Size _size = MediaQuery.of(context).size;
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(
//           Radius.circular(10.0),
//         ),
//         color: context.watch<PaletteController>().palette.captionColor,
//       ),
//       padding: _size.width < 750
//           ? EdgeInsets.symmetric(
//           horizontal: defaultPadding, vertical: defaultPadding * 1.25)
//           : null,
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 info.leftScoreName,
//                 style: Theme.of(context).textTheme.caption!.copyWith(
//                     color: info.percentage >= 50
//                         ? info.color
//                         : info.color.withOpacity(0.5),
//                     fontSize: 12),
//               ),
//               Text(
//                 info.rightScoreName,
//                 style: Theme.of(context).textTheme.caption!.copyWith(
//                     color: info.percentage < 50
//                         ? info.color
//                         : info.color.withOpacity(0.5),
//                     fontSize: 12),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: defaultPadding * 0.5,
//           ),
//           ProgressLine(
//             color: info.color,
//             percentage: info.percentage,
//           ),
//           SizedBox(
//             height: defaultPadding * 0.5,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "${info.percentage}%",
//                 style: Theme.of(context).textTheme.caption!.copyWith(
//                     color: info.percentage >= 50
//                         ? info.color
//                         : info.color.withOpacity(0.5),
//                     fontSize: 13),
//               ),
//               Text(
//                 "${100 - info.percentage}%",
//                 style: Theme.of(context).textTheme.caption!.copyWith(
//                     color: info.percentage < 50
//                         ? info.color
//                         : info.color.withOpacity(0.5),
//                     fontSize: 13),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    required this.color,
    required this.percentage,
  }) : super(key: key);

  final Color color;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    final double height = 6;
    return Stack(
      alignment:
          percentage >= 50 ? Alignment.centerLeft : Alignment.centerRight,
      children: [
        Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth *
                ((percentage <= 50 ? 100 - percentage : percentage) / 100),
            height: height,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),
      ],
    );
  }
}
