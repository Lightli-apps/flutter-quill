import 'package:flutter/widgets.dart';

import '../provider.dart';

class QuillEditorBulletPoint extends StatelessWidget {
  const QuillEditorBulletPoint({
    required this.style,
    required this.width,
    this.padding = 0,
    this.backgroundColor,
    this.textAlign,
    super.key,
  });

  final TextStyle style;
  final double width;
  final double padding;
  final Color? backgroundColor;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    // === BULLET ALIGNMENT WITHIN CONTAINER ===
    // This ensures bullet aligns properly within its allocated space based on text alignment.
    // Note: The main positioning is handled in text_line.dart performLayout().
    // This just aligns the bullet within its own container.
    final bulletAlignment = switch (textAlign) {
      TextAlign.center => Alignment.center,
      TextAlign.right => Alignment.centerRight,
      TextAlign.end => Alignment.centerRight,
      TextAlign.left => Alignment.centerLeft,
      TextAlign.start => Alignment.centerLeft,
      _ => Alignment.centerLeft,
    };

    final customWidget = context
        .quillEditorConfigurations?.elementOptions.unorderedList.customWidget;

    return Container(
      width: width,
      padding: EdgeInsetsDirectional.only(end: padding),
      color: backgroundColor,
      child: Align(
        alignment: bulletAlignment,
        child: customWidget ??
            Text(
              '•',
              style: style,
            ),
      ),
    );
  }
}
