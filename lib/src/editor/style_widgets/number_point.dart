import 'package:flutter/widgets.dart';
import '../../../flutter_quill.dart';

class QuillEditorNumberPoint extends StatelessWidget {
  const QuillEditorNumberPoint({
    required this.index,
    required this.indentLevelCounts,
    required this.count,
    required this.style,
    required this.width,
    required this.attrs,
    this.textAlign,
    this.withDot = true,
    this.padding = 0.0,
    super.key,
    this.backgroundColor,
  });

  final String index;
  final Map<int?, int> indentLevelCounts;
  final int count;
  final TextStyle style;
  final double width;
  final Map<String, Attribute> attrs;
  final bool withDot;
  final double padding;
  final Color? backgroundColor;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    // Adjust alignment based on text alignment
    final numberAlignment = switch (textAlign) {
      TextAlign.center => Alignment.center,
      TextAlign.right => Alignment.centerRight,
      TextAlign.end => Alignment.centerRight,
      TextAlign.left => Alignment.centerLeft,
      TextAlign.start => Alignment.centerLeft,
      _ => Alignment.centerLeft,
    };

    if (!attrs.containsKey(Attribute.indent.key) && indentLevelCounts.isEmpty) {
      return Container(
        width: width,
        padding: EdgeInsetsDirectional.only(end: padding),
        color: backgroundColor,
        child: Align(
          alignment: numberAlignment,
          child: context.quillEditorConfigurations?.elementOptions.orderedList
                  .customWidget ??
              Text(
                withDot ? '$index.' : index,
                style: style,
              ),
        ),
      );
    }
    return Container(
      width: width,
      padding: EdgeInsetsDirectional.only(end: padding),
      color: backgroundColor,
      child: Align(
        alignment: numberAlignment,
        child: context.quillEditorConfigurations?.elementOptions.orderedList
                .customWidget ??
            Text(
              withDot ? '$index.' : index,
              style: style,
            ),
      ),
    );
  }
}
