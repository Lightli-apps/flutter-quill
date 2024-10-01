import 'package:flutter/material.dart';

import '../../document/attribute.dart';
import '../../l10n/extensions/localizations_ext.dart';

//import '../base_button/stateless_base_button.dart';
import '../base_toolbar.dart' show QuillToolbarIconButton;
import 'package:flutter_svg/flutter_svg.dart';
import '../config/simple_toolbar_configurations.dart';
import '../base_button/base_value_button.dart';

typedef QuillToolbarClearFormatBaseButton
    = QuillToolbarBaseButton<QuillToolbarClearFormatButtonOptions, QuillToolbarClearFormatButtonExtraOptions>;

typedef QuillToolbarClearFormatBaseButtonState<W extends QuillToolbarClearFormatButton>
    = QuillToolbarCommonButtonState<W, QuillToolbarClearFormatButtonOptions, QuillToolbarClearFormatButtonExtraOptions>;

class QuillToolbarClearFormatButton extends QuillToolbarClearFormatBaseButton {
  const QuillToolbarClearFormatButton({
    required super.controller,
    super.options = const QuillToolbarClearFormatButtonOptions(),
    super.key,
  });

  @override
  QuillToolbarClearFormatButtonState createState() => QuillToolbarClearFormatButtonState();
}

class QuillToolbarClearFormatButtonState extends QuillToolbarClearFormatBaseButtonState {
  bool isSelected = false;

  @override
  String get defaultTooltip => context.loc.clearFormat;

  @override
  Widget get defaultIconData => SvgPicture.asset(
        'assets/icons/text_style_toolbar/no_paragraph.svg',
        fit: BoxFit.scaleDown,
        colorFilter: ColorFilter.mode(
            Theme.of(context).brightness == Brightness.dark ? Colors.white : const Color(0xFF3a3a3a), BlendMode.srcIn),
        // colorFilter: ColorFilter.mode(
        //     !(widget.controller.getSelectionStyle().containsKey('indent') ||
        //         widget.controller.getSelectionStyle().containsKey('bullet') ||
        //         widget.controller.getSelectionStyle().containsKey('ordered'))
        //         ?
        //     Theme
        //         .of(context)
        //         .brightness == Brightness.light ?
        //     Colors.white :
        //     Colors.black : Theme
        //         .of(context)
        //         .textTheme
        //         .headlineSmall!
        //         .color!, BlendMode.srcIn)
      );

  void _sharedOnPressed() {
    final attributes = <Attribute>{};
    for (final style in controller.getAllSelectionStyles()) {
      for (final attr in style.attributes.values) {
        attributes.add(attr);
      }
    }
    for (final attribute in attributes) {
      controller.formatSelection(Attribute.clone(attribute, null));
    }

    setState(() {
      isSelected = !(controller.getSelectionStyle().containsKey(Attribute.list.key) ||
          controller.getSelectionStyle().containsKey(Attribute.indent.key));
    });
  }

  @override
  Widget build(BuildContext context) {
    final childBuilder = options.childBuilder ?? baseButtonExtraOptions?.childBuilder;

    if (childBuilder != null) {
      return childBuilder(
        options,
        QuillToolbarClearFormatButtonExtraOptions(
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
      isSelected: isSelected,
      onPressed: _sharedOnPressed,
      afterPressed: afterButtonPressed,
      iconTheme: iconTheme,
    );
  }
}

// class QuillToolbarClearFormatButton extends QuillToolbarBaseButton {
//   const QuillToolbarClearFormatButton({
//     required super.controller,
//     super.options,
//     super.key,
//   });
//
//   void _sharedOnPressed() {
//     final attributes = <Attribute>{};
//     for (final style in controller.getAllSelectionStyles()) {
//       for (final attr in style.attributes.values) {
//         attributes.add(attr);
//       }
//     }
//     for (final attribute in attributes) {
//       controller.formatSelection(Attribute.clone(attribute, null));
//     }
//   }
//
//   @override
//   Widget buildButton(BuildContext context) {
//     final isSelected = !(controller.getSelectionStyle().containsKey('indent') &&
//         !controller.getSelectionStyle().containsKey('bullet') &&
//         !controller.getSelectionStyle().containsKey('ordered'));
//
//     return QuillToolbarIconButton(
//       tooltip: tooltip(context),
//       icon:
//       iconData(context),
//       isSelected: isSelected,
//       onPressed: _sharedOnPressed,
//       afterPressed: afterButtonPressed(context),
//       iconTheme: iconTheme(context),
//     );
//   }
//
//   @override
//   Widget? buildCustomChildBuilder(BuildContext context) {
//     return options?.childBuilder?.call(
//       options,
//       QuillToolbarClearFormatButtonExtraOptions(
//         controller: controller,
//         context: context,
//         onPressed: () {
//           _sharedOnPressed();
//           afterButtonPressed(context)?.call();
//         },
//       ),
//     );
//   }
//
//   @override
//   Widget Function(BuildContext context) get getDefaultIconData =>
//           (context) =>
//           SvgPicture.asset("assets/icons/text_style_toolbar/no_paragraph.svg", fit: BoxFit.scaleDown,
//
//           );
//
//   @override
//   String Function(BuildContext context) get getDefaultTooltip =>
//           (context) => context.loc.clearFormat;
// }
