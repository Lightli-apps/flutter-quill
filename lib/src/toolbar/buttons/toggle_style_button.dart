import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../common/utils/widgets.dart';
import '../../document/attribute.dart';
import '../../document/style.dart';
import '../../l10n/extensions/localizations_ext.dart';
import '../base_button/base_value_button.dart';
import '../base_toolbar.dart';
import '../simple_toolbar_provider.dart';
import '../theme/quill_icon_theme.dart';

typedef ToggleStyleButtonBuilder = Widget Function(
    BuildContext context,
    Attribute attribute,
    IconData icon,
    bool? isToggled,
    VoidCallback? onPressed,
    VoidCallback? afterPressed, [
    double iconSize,
    QuillIconTheme? iconTheme,
    ]);

class QuillToolbarToggleStyleButton extends QuillToolbarToggleStyleBaseButton {
  const QuillToolbarToggleStyleButton({
    required super.controller,
    required this.attribute,
    super.options = const QuillToolbarToggleStyleButtonOptions(),
    super.key,
  });

  final Attribute attribute;

  @override
  QuillToolbarToggleStyleButtonState createState() =>
      QuillToolbarToggleStyleButtonState();
}

class QuillToolbarToggleStyleButtonState extends QuillToolbarToggleStyleBaseButtonState<
    QuillToolbarToggleStyleButton> {
  Style get _selectionStyle => controller.getSelectionStyle();

  @override
  bool get currentStateValue => _getIsToggled(_selectionStyle.attributes);

  (String, Widget) get _defaultTooltipAndIconData {
    switch (widget.attribute.key) {
      case 'bold':
        return (context.loc.bold, SvgPicture.asset(
          'assets/icons/text_style_toolbar/bold_icon.svg', fit: BoxFit.scaleDown,
          colorFilter: ColorFilter.mode(currentStateValue ?
          Theme
              .of(context)
              .brightness == Brightness.light ?
          Colors.white :
          Colors.black : Theme
              .of(context)
              .textTheme
              .headlineSmall!
              .color!, BlendMode.srcIn),
        ));
      case 'script':
        if (widget.attribute.value == ScriptAttributes.sub.value) {
          return (context.loc.subscript, const Icon(Icons.subscript));
        }
        return (context.loc.superscript, const Icon(Icons.superscript));
      case 'italic':
        return (context.loc.italic, SvgPicture.asset(
          'assets/icons/text_style_toolbar/italic_icon.svg', fit: BoxFit.scaleDown,
          colorFilter: ColorFilter.mode(currentStateValue ?
          Theme
              .of(context)
              .brightness == Brightness.light ?
          Colors.white :
          Colors.black : Theme
              .of(context)
              .textTheme
              .headlineSmall!
              .color!, BlendMode.srcIn),));
      case 'small':
        return (context.loc.small, const Icon(Icons.format_size));
      case 'underline':
        return (context.loc.underline, SvgPicture.asset(
          'assets/icons/text_style_toolbar/underline_icon.svg', fit: BoxFit.scaleDown,
          colorFilter: ColorFilter.mode(currentStateValue ?
          Theme
              .of(context)
              .brightness == Brightness.light ?
          Colors.white :
          Colors.black : Theme
              .of(context)
              .textTheme
              .headlineSmall!
              .color!, BlendMode.srcIn),));
      case 'strike':
        return (context.loc.strikeThrough, SvgPicture.asset(
          'assets/icons/text_style_toolbar/strikethrough_icon.svg', fit: BoxFit.scaleDown,
          colorFilter: ColorFilter.mode(currentStateValue ?
          Theme
              .of(context)
              .brightness == Brightness.light ?
          Colors.white :
          Colors.black : Theme
              .of(context)
              .textTheme
              .headlineSmall!
              .color!, BlendMode.srcIn),));
      case 'code':
        return (context.loc.inlineCode, const Icon(Icons.code));
      case 'direction':
        return (context.loc.textDirection, const Icon(Icons.format_textdirection_r_to_l));
      case 'list':
        if (widget.attribute.value == 'bullet') {
          return (context.loc.bulletList, SvgPicture.asset(
            'assets/icons/text_style_toolbar/bullet_paragraph.svg', fit: BoxFit.scaleDown,
            colorFilter: ColorFilter.mode(currentStateValue ?
            Theme
                .of(context)
                .brightness == Brightness.light ?
            Colors.white :
            Colors.black : Theme
                .of(context)
                .textTheme
                .headlineSmall!
                .color!, BlendMode.srcIn),));
        }
        return (context.loc.numberedList, SvgPicture.asset(
          'assets/icons/text_style_toolbar/number_paragraph.svg', fit: BoxFit.scaleDown,
          colorFilter: ColorFilter.mode(currentStateValue ?
          Theme
              .of(context)
              .brightness == Brightness.light ?
          Colors.white :
          Colors.black : Theme
              .of(context)
              .textTheme
              .headlineSmall!
              .color!, BlendMode.srcIn),));
      case 'code-block':
        return (context.loc.codeBlock, const Icon(Icons.code));
      case 'blockquote':
        return (context.loc.quote, const Icon(Icons.format_quote));
      case 'align':
        return switch (widget.attribute.value) {
          'left' =>
          (context.loc.alignLeft, SvgPicture.asset(
            'assets/icons/text_style_toolbar/left_alignment.svg', fit: BoxFit.scaleDown,
            colorFilter: ColorFilter.mode(currentStateValue ?
            Theme
                .of(context)
                .brightness == Brightness.light ?
            Colors.white :
            Colors.black : Theme
                .of(context)
                .textTheme
                .headlineSmall!
                .color!, BlendMode.srcIn),)),
          'right' =>
          (context.loc.alignRight, SvgPicture.asset(
            'assets/icons/text_style_toolbar/right_alignment.svg', fit: BoxFit.scaleDown,
            colorFilter: ColorFilter.mode(currentStateValue ?
            Theme
                .of(context)
                .brightness == Brightness.light ?
            Colors.white :
            Colors.black : Theme
                .of(context)
                .textTheme
                .headlineSmall!
                .color!, BlendMode.srcIn),)),
          'center' =>
          (context.loc.alignCenter, SvgPicture.asset(
            'assets/icons/text_style_toolbar/center_alignment.svg', fit: BoxFit.scaleDown,
            colorFilter: ColorFilter.mode(currentStateValue ?
            Theme
                .of(context)
                .brightness == Brightness.light ?
            Colors.white :
            Colors.black : Theme
                .of(context)
                .textTheme
                .headlineSmall!
                .color!, BlendMode.srcIn),)),
          'justify' =>
          (context.loc.alignJustify, SvgPicture.asset(
            'assets/icons/text_style_toolbar/justified_alignment.svg', fit: BoxFit.scaleDown,
            colorFilter: ColorFilter.mode(currentStateValue ?
            Theme
                .of(context)
                .brightness == Brightness.light ?
            Colors.white :
            Colors.black : Theme
                .of(context)
                .textTheme
                .headlineSmall!
                .color!, BlendMode.srcIn),)),
          Object() => throw ArgumentError(widget.attribute.value),
          null =>
          (context.loc.alignLeft, SvgPicture.asset(
            'assets/icons/text_style_toolbar/left_alignment.svg', fit: BoxFit.scaleDown,
            colorFilter: ColorFilter.mode(widget.attribute.value == null ?
            Theme
                .of(context)
                .brightness == Brightness.light ?
            Colors.white :
            Colors.black : Theme
                .of(context)
                .textTheme
                .headlineSmall!
                .color!, BlendMode.srcIn),), ),
        };
      default:
        throw ArgumentError(
          'Could not find the default tooltip for '
              '${widget.attribute.toString()}',
        );
    }
  }

  @override
  String get defaultTooltip => _defaultTooltipAndIconData.$1;

  @override
  Widget get defaultIconData => _defaultTooltipAndIconData.$2;

  void _onPressed() {
    _toggleAttribute();
    afterButtonPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    final childBuilder = options.childBuilder ??
        context.quillToolbarBaseButtonOptions?.childBuilder;
    if (childBuilder != null) {
      return childBuilder(
        options,
        QuillToolbarToggleStyleButtonExtraOptions(
          context: context,
          controller: controller,
          onPressed: _onPressed,
          isToggled: currentValue,
        ),
      );
    }
    return UtilityWidgets.maybeTooltip(
      message: tooltip,
      child: defaultToggleStyleButtonBuilder(
        context,
        widget.attribute,
        iconData,
        currentValue,
        _toggleAttribute,
        afterButtonPressed,
        iconSize,
        iconButtonFactor,
        iconTheme,
      ),
    );
  }

  bool _getIsToggled(Map<String, Attribute> attrs) {
    if (widget.attribute.key == Attribute.list.key ||
        widget.attribute.key == Attribute.header.key ||
        widget.attribute.key == Attribute.script.key ||
        widget.attribute.key == Attribute.align.key) {
      final attribute = attrs[widget.attribute.key];
      if (attribute == null) {
        return false;
      }
      return attribute.value == widget.attribute.value;
    }
    return attrs.containsKey(widget.attribute.key);
  }

  void _toggleAttribute() {
    controller
      ..skipRequestKeyboard = !widget.attribute.isInline
      ..formatSelection(
        currentValue
            ? Attribute.clone(widget.attribute, null)
            : widget.attribute,
      );
  }
}

Widget defaultToggleStyleButtonBuilder(BuildContext context,
    Attribute attribute,
    Widget icon,
    bool? isToggled,
    VoidCallback? onPressed,
    VoidCallback? afterPressed, [
      double iconSize = kDefaultIconSize,
      double iconButtonFactor = kDefaultIconButtonFactor,
      QuillIconTheme? iconTheme,
    ]) {
  final isEnabled = onPressed != null;
  return QuillToolbarIconButton(
    icon: icon,
    isSelected: isEnabled ? isToggled == true : false,
    onPressed: onPressed,
    afterPressed: afterPressed,
    iconTheme: iconTheme,
  );
}
