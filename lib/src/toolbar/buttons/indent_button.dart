import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../flutter_quill.dart';
import '../../l10n/extensions/localizations_ext.dart';
import '../base_button/base_value_button.dart';
import '../base_toolbar.dart' show QuillToolbarIconButton;
import '../config/simple_toolbar_configurations.dart';

typedef QuillToolbarIndentBaseButton
    = QuillToolbarBaseButton<QuillToolbarIndentButtonOptions, QuillToolbarIndentButtonExtraOptions>;

typedef QuillToolbarIndentBaseButtonState<W extends QuillToolbarIndentButton>
    = QuillToolbarCommonButtonState<W, QuillToolbarIndentButtonOptions, QuillToolbarIndentButtonExtraOptions>;

class QuillToolbarIndentButton extends QuillToolbarIndentBaseButton {
  const QuillToolbarIndentButton({
    required super.controller,
    required this.isIncrease,
    super.options = const QuillToolbarIndentButtonOptions(),
    super.key,
  });

  final bool isIncrease;

  @override
  QuillToolbarIndentButtonState createState() => QuillToolbarIndentButtonState();
}

class QuillToolbarIndentButtonState extends QuillToolbarIndentBaseButtonState {
  @override
  String get defaultTooltip => widget.isIncrease ? context.loc.increaseIndent : context.loc.decreaseIndent;

  @override
  Widget get defaultIconData => widget.isIncrease
      ? SvgPicture.asset(
          'assets/icons/text_style_toolbar/indent_paragraph.svg',
          fit: BoxFit.scaleDown,
          colorFilter: ColorFilter.mode(
              Theme.of(context).brightness == Brightness.dark ? Colors.white : const Color(0xFF3a3a3a),
              BlendMode.srcIn),
        )
      : const Icon(Icons.format_indent_decrease);

  void _sharedOnPressed() {
    widget.controller.indentSelection(widget.isIncrease);
  }

  @override
  Widget build(BuildContext context) {
    final childBuilder = options.childBuilder ?? baseButtonExtraOptions?.childBuilder;

    if (childBuilder != null) {
      return childBuilder(
        options,
        QuillToolbarIndentButtonExtraOptions(
          controller: controller,
          context: context,
          onPressed: () {
            _sharedOnPressed();
            afterButtonPressed?.call();
          },
        ),
      );
    }

    // final iconColor = iconTheme?.iconUnselectedFillColor;
    return QuillToolbarIconButton(
      tooltip: tooltip,
      icon: iconData,
      isSelected: controller.getSelectionStyle().containsKey(Attribute.indent.key),
      onPressed: _sharedOnPressed,
      afterPressed: afterButtonPressed,
      iconTheme: iconTheme,
    );
  }
}
