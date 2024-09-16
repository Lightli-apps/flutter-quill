import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/utils/color.dart';
import '../../../document/attribute.dart';
import '../../../document/style.dart';
import '../../../editor_toolbar_shared/quill_configurations_ext.dart';
import '../../../l10n/extensions/localizations_ext.dart';
import '../../../l10n/widgets/localizations.dart';
import '../../../widgets/selectable_color_quill.dart';
import '../../base_button/base_value_button.dart';
import '../../config/buttons/color_configurations.dart';
import 'color_dialog.dart';

typedef QuillToolbarColorBaseButton
    = QuillToolbarBaseButton<QuillToolbarColorButtonOptions, QuillToolbarColorButtonExtraOptions>;

typedef QuillToolbarColorBaseButtonState<W extends QuillToolbarColorButton>
    = QuillToolbarCommonButtonState<W, QuillToolbarColorButtonOptions, QuillToolbarColorButtonExtraOptions>;

/// Controls color styles.
///
/// When pressed, this button displays overlay toolbar with
/// buttons for each color.
class QuillToolbarColorButton extends QuillToolbarColorBaseButton {
  const QuillToolbarColorButton({
    required super.controller,
    required this.isBackground,
    this.selectableColorsText = const [],
    this.selectableColorsBackground = const [],
    super.options = const QuillToolbarColorButtonOptions(),
    super.key,
  });

  /// Is this background color button or font color
  final bool isBackground;
  final List<Color> selectableColorsText;
  final List<Color> selectableColorsBackground;

  @override
  QuillToolbarColorButtonState createState() => QuillToolbarColorButtonState();
}

class QuillToolbarColorButtonState extends QuillToolbarColorBaseButtonState {
  late bool _isToggledColor;
  late bool _isToggledBackground;
  late bool _isWhite;
  late bool _isWhiteBackground;

  @override
  String get defaultTooltip => widget.isBackground ? context.loc.backgroundColor : context.loc.fontColor;

  Style get _selectionStyle => widget.controller.getSelectionStyle();

  int selectedTextColorIndex = 0;
  int selectedBackgroundColorIndex = 0;

  void _didChangeEditingValue() {
    setState(() {
      _isToggledColor = _getIsToggledColor(widget.controller.getSelectionStyle().attributes);
      _isToggledBackground = _getIsToggledBackground(widget.controller.getSelectionStyle().attributes);
      _isWhite = _isToggledColor && _selectionStyle.attributes['color']!.value == '#ffffff';
      _isWhiteBackground = _isToggledBackground && _selectionStyle.attributes['background']!.value == '#ffffff';
    });
  }

  @override
  void initState() {
    super.initState();
    _isToggledColor = _getIsToggledColor(_selectionStyle.attributes);
    _isToggledBackground = _getIsToggledBackground(_selectionStyle.attributes);
    _isWhite = _isToggledColor && _selectionStyle.attributes['color']!.value == '#ffffff';
    _isWhiteBackground = _isToggledBackground && _selectionStyle.attributes['background']!.value == '#ffffff';
    widget.controller.addListener(_didChangeEditingValue);
  }

  bool _getIsToggledColor(Map<String, Attribute> attrs) {
    return attrs.containsKey(Attribute.color.key);
  }

  bool _getIsToggledBackground(Map<String, Attribute> attrs) {
    return attrs.containsKey(Attribute.background.key);
  }

  @override
  void didUpdateWidget(covariant QuillToolbarColorButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_didChangeEditingValue);
      widget.controller.addListener(_didChangeEditingValue);
      _isToggledColor = _getIsToggledColor(_selectionStyle.attributes);
      _isToggledBackground = _getIsToggledBackground(_selectionStyle.attributes);
      _isWhite = _isToggledColor && _selectionStyle.attributes['color']!.value == '#ffffff';
      _isWhiteBackground = _isToggledBackground && _selectionStyle.attributes['background']!.value == '#ffffff';
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_didChangeEditingValue);
    super.dispose();
  }

  @override
  Widget get defaultIconData =>
      widget.isBackground ? const Icon(Icons.format_color_fill) : const Icon(Icons.color_lens);

  @override
  Widget build(BuildContext context) {
    final iconColor = _isToggledColor && !widget.isBackground && !_isWhite
        ? stringToColor(_selectionStyle.attributes['color']!.value)
        : null;

    final iconColorBackground = _isToggledBackground && widget.isBackground && !_isWhiteBackground
        ? stringToColor(_selectionStyle.attributes['background']!.value)
        : null;

    final fillColor = _isToggledColor && !widget.isBackground && _isWhite ? stringToColor('#ffffff') : null;
    final fillColorBackground =
        _isToggledBackground && widget.isBackground && _isWhiteBackground ? stringToColor('#ffffff') : null;

    final childBuilder = options.childBuilder ?? baseButtonExtraOptions?.childBuilder;
    if (childBuilder != null) {
      return childBuilder(
        options,
        QuillToolbarColorButtonExtraOptions(
          controller: controller,
          context: context,
          onPressed: () {
            _showColorPicker();
            afterButtonPressed?.call();
          },
          iconColor: iconColor,
          iconColorBackground: iconColorBackground,
          fillColor: fillColor,
          fillColorBackground: fillColorBackground,
        ),
      );
    }

    return !widget.isBackground
        ?

        /// ----------- Foreground colors ---------------
        Row(
            children: List.generate(
              widget.selectableColorsText.length,
              (index) => SelectableColorQuill(
                color: index == 0
                    ? Theme.of(context).textTheme.headlineSmall!.color!
                    : widget.selectableColorsText.elementAt(index),
                onDrag: (value) {
                  final initPosition = (20.w * selectedTextColorIndex + 70.w - 20.w * selectedTextColorIndex) / 2;
                  if ((value.localPosition.dx < initPosition) &&
                      value.localPosition.dx < 20.w * selectedTextColorIndex) {
                    setState(() {
                      if (selectedTextColorIndex > 0) {
                        selectedTextColorIndex--;
                        final selectedColor = widget.selectableColorsText.elementAt(selectedTextColorIndex);
                        final hex = colorToHex(selectedColor);
                        widget.controller.formatSelection(
                          ColorAttribute('#$hex'),
                        );
                      }
                    });
                  } else if (value.localPosition.dx > 20.w * selectedTextColorIndex + 70.w &&
                      (initPosition < value.localPosition.dx)) {
                    setState(() {
                      if (selectedTextColorIndex < widget.selectableColorsText.length - 1) {
                        selectedTextColorIndex++;
                        final selectedColor = widget.selectableColorsText.elementAt(selectedTextColorIndex);
                        final hex = colorToHex(selectedColor);
                        widget.controller.formatSelection(
                          ColorAttribute('#$hex'),
                        );
                      }
                    });
                  }
                },
                onClick: () {
                  setState(() {
                    selectedTextColorIndex = index;
                    final selectedColor = widget.selectableColorsText.elementAt(selectedTextColorIndex);
                    final hex = colorToHex(selectedColor);
                    widget.controller.formatSelection(
                      ColorAttribute('#$hex'),
                    );
                  });
                },
                isOn: selectedTextColorIndex == index,
                borderLeft: index == 0,
                borderRight: index == widget.selectableColorsText.length - 1,
              ),
            ),
          )
        :

        /// ----------- Background colors ---------------

        Row(
            children: List.generate(
              widget.selectableColorsBackground.length,
              (index) => SelectableColorQuill(
                color: index == 0
                    ? Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : widget.selectableColorsBackground.elementAt(0)
                    : widget.selectableColorsBackground.elementAt(index),
                onDrag: (value) {
                  if (value.localPosition.dx < 40.w * selectedBackgroundColorIndex) {
                    setState(() {
                      if (selectedBackgroundColorIndex > 0) {
                        selectedBackgroundColorIndex--;
                        final selectedColor = index == 0
                            ? Colors.transparent
                            : widget.selectableColorsBackground.elementAt(selectedBackgroundColorIndex);
                        final hex = colorToHex(selectedColor);
                        widget.controller.formatSelection(
                          BackgroundAttribute('#$hex'),
                        );
                      }
                    });
                  } else if (value.localPosition.dx > 40.w * selectedBackgroundColorIndex + 70.w) {
                    setState(() {
                      if (selectedTextColorIndex < widget.selectableColorsBackground.length - 1) {
                        selectedBackgroundColorIndex++;
                        final selectedColor = index == 0
                            ? Colors.transparent
                            : widget.selectableColorsBackground.elementAt(selectedBackgroundColorIndex);
                        final hex = colorToHex(selectedColor);
                        widget.controller.formatSelection(
                          BackgroundAttribute('#$hex'),
                        );
                      }
                    });
                  }
                },
                onClick: () {
                  setState(() {
                    selectedBackgroundColorIndex = index;
                    final selectedColor = index == 0
                        ? Colors.transparent
                        : widget.selectableColorsBackground.elementAt(selectedBackgroundColorIndex);
                    final hex = colorToHex(selectedColor);
                    widget.controller.formatSelection(
                      BackgroundAttribute('#$hex'),
                    );
                  });
                },
                isOn: selectedBackgroundColorIndex == index,
                borderLeft: index == 0,
                borderRight: index == widget.selectableColorsBackground.length - 1,
                showIcon: true,
              ),
            ),
          );
  }

  void _changeColor(BuildContext context, Color? color) {
    if (color == null) {
      widget.controller.formatSelection(
        widget.isBackground ? const BackgroundAttribute(null) : const ColorAttribute(null),
      );
      return;
    }
    var hex = colorToHex(color);
    hex = '#$hex';
    widget.controller.formatSelection(
      widget.isBackground ? BackgroundAttribute(hex) : ColorAttribute(hex),
    );
  }

  Future<void> _showColorPicker() async {
    final customCallback = options.customOnPressedCallback;
    if (customCallback != null) {
      await customCallback(controller, widget.isBackground);
      return;
    }
    showDialog<String>(
      context: context,
      barrierColor:
          options.dialogBarrierColor ?? context.quillSharedConfigurations?.dialogBarrierColor ?? Colors.black54,
      builder: (_) => FlutterQuillLocalizationsWidget(
        child: ColorPickerDialog(
          isBackground: widget.isBackground,
          onRequestChangeColor: _changeColor,
          isToggledColor: _isToggledColor,
          selectionStyle: _selectionStyle,
        ),
      ),
    );
  }
}

Color hexToColor(String? hexString) {
  if (hexString == null) {
    return Colors.black;
  }
  final hexRegex = RegExp(r'([0-9A-Fa-f]{3}|[0-9A-Fa-f]{6})$');

  hexString = hexString.replaceAll('#', '');
  if (!hexRegex.hasMatch(hexString)) {
    return Colors.black;
  }

  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString);
  return Color(int.tryParse(buffer.toString(), radix: 16) ?? 0xFF000000);
}

String colorToHex(Color color) {
  return color.value.toRadixString(16).padLeft(8, '0').toUpperCase();
}
