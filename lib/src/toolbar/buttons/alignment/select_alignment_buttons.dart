import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../controller/quill_controller.dart';
import '../../../document/attribute.dart';
import '../../base_toolbar.dart';

class QuillToolbarSelectAlignmentButtons extends StatelessWidget {
  const QuillToolbarSelectAlignmentButtons({
    required this.controller,
    this.options = const QuillToolbarSelectAlignmentButtonOptions(),
    super.key,
  });

  final QuillController controller;
  final QuillToolbarSelectAlignmentButtonOptions options;

  List<Attribute> get _attrbuites {
    return options.attributes ??
        [
          if (options.showLeftAlignment) Attribute.leftAlignment,
          if (options.showCenterAlignment) Attribute.centerAlignment,
          if (options.showRightAlignment) Attribute.rightAlignment,
          if (options.showJustifyAlignment) Attribute.justifyAlignment,
        ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.w,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _attrbuites
            .map((e) => QuillToolbarToggleStyleButton(
                  controller: controller,
                  attribute: e,
                  options: QuillToolbarToggleStyleButtonOptions(
                    iconData: options.iconData,
                    iconSize: options.iconSize,
                    iconButtonFactor: options.iconButtonFactor,
                    afterButtonPressed: options.afterButtonPressed,
                    iconTheme: options.iconTheme,
                    tooltip: options.tooltip,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
