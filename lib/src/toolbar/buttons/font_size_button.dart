import 'package:flutter/material.dart';

import '../../../extensions.dart';
import '../../common/utils/font.dart';
import '../../document/attribute.dart';
import '../../l10n/extensions/localizations_ext.dart';
import '../../widgets/textstyle_buttons_quill.dart';
import '../base_button/base_value_button.dart';
import '../base_toolbar.dart';
import '../simple_toolbar_provider.dart';

class QuillToolbarFontSizeButton
    extends QuillToolbarBaseButton<QuillToolbarFontSizeButtonOptions, QuillToolbarFontSizeButtonExtraOptions> {
  QuillToolbarFontSizeButton({
    required super.controller,
    @Deprecated('Please use the default display text from the options') this.defaultDisplayText,
    super.options = const QuillToolbarFontSizeButtonOptions(),
    super.key,
  })  : assert(options.rawItemsMap?.isNotEmpty ?? true),
        assert(options.initialValue == '0' || (options.initialValue?.isNotEmpty ?? true));

  final String? defaultDisplayText;

  @override
  QuillToolbarFontSizeButtonState createState() => QuillToolbarFontSizeButtonState();
}

class QuillToolbarFontSizeButtonState extends QuillToolbarBaseButtonState<QuillToolbarFontSizeButton,
    QuillToolbarFontSizeButtonOptions, QuillToolbarFontSizeButtonExtraOptions, String> {
  final _menuController = MenuController();

  Map<String, String> get rawItemsMap {
    final fontSizes = options.rawItemsMap ??
        context.quillSimpleToolbarConfigurations?.fontSizesValues ??
        {context.loc.small: 'small', context.loc.large: 'large', context.loc.huge: 'huge', context.loc.clear: '0'};
    return fontSizes;
  }

  String? getLabel(String? currentValue) {
    return switch (currentValue) {
      'small' => context.loc.small,
      'large' => context.loc.large,
      'huge' => context.loc.huge,
      String() => currentValue,
      null => null,
    };
  }

  String get _defaultDisplayText {
    return options.initialValue ??
        widget.options.defaultDisplayText ??
        widget.defaultDisplayText ??
        context.loc.fontSize;
  }

  @override
  String get currentStateValue {
    final attribute = controller.getSelectionStyle().attributes[options.attribute.key];
    return attribute == null ? _defaultDisplayText : (_getKeyName(attribute.value) ?? _defaultDisplayText);
  }

  String? _getKeyName(dynamic value) {
    for (final entry in rawItemsMap.entries) {
      if (getFontSize(entry.value) == getFontSize(value)) {
        return entry.key;
      }
    }
    return null;
  }

  @override
  String get defaultTooltip => context.loc.fontSize;

  @override
  Widget get defaultIconData => const Icon(Icons.format_size_outlined);

  void _onDropdownButtonPressed() {
    if (_menuController.isOpen) {
      _menuController.close();
    } else {
      _menuController.open();
    }
    afterButtonPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    final baseButtonConfigurations = context.quillToolbarBaseButtonOptions;
    final childBuilder = options.childBuilder ?? baseButtonConfigurations?.childBuilder;
    if (childBuilder != null) {
      return childBuilder(
        options,
        QuillToolbarFontSizeButtonExtraOptions(
          controller: controller,
          currentValue: currentValue,
          defaultDisplayText: _defaultDisplayText,
          context: context,
          onPressed: _onDropdownButtonPressed,
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextstyleButtonQuill(
          icon: '8',
          noIcon: true,
          onTap: () {
            const newValue = 'small';
            final keyName = _getKeyName(newValue);
            setState(() {
              if (keyName != context.loc.clear) {
                currentValue = keyName ?? _defaultDisplayText;
              } else {
                currentValue = _defaultDisplayText;
              }
              if (keyName != null) {
                controller.formatSelection(
                  Attribute.fromKeyValue(
                    Attribute.size.key,
                    newValue == '0' ? null : getFontSize(newValue),
                  ),
                );
                options.onSelected?.call(newValue);
              }
            });
          },
          isOn: currentValue == _getKeyName('small'),
        ),
        TextstyleButtonQuill(
          icon: '10',
          noIcon: true,
          onTap: () {
            const newValue = '0';

            final keyName = _getKeyName(newValue);
            setState(() {
              if (keyName != context.loc.clear) {
                currentValue = keyName ?? _defaultDisplayText;
              } else {
                currentValue = _defaultDisplayText;
              }
              if (keyName != null) {
                controller.formatSelection(
                  Attribute.fromKeyValue(
                    Attribute.size.key,
                    newValue == '0' ? null : getFontSize(newValue),
                  ),
                );
                options.onSelected?.call(newValue);
              }
            });
          },
          isOn: currentValue != _getKeyName('small') &&
              currentValue != _getKeyName('large') &&
              currentValue != _getKeyName('huge'),
        ),
        TextstyleButtonQuill(
          icon: '12',
          noIcon: true,
          onTap: () {
            const newValue = 'large';

            final keyName = _getKeyName(newValue);
            setState(() {
              if (keyName != context.loc.clear) {
                currentValue = keyName ?? _defaultDisplayText;
              } else {
                currentValue = _defaultDisplayText;
              }
              if (keyName != null) {
                controller.formatSelection(
                  Attribute.fromKeyValue(
                    Attribute.size.key,
                    newValue == '0' ? null : getFontSize(newValue),
                  ),
                );
                options.onSelected?.call(newValue);
              }
            });
          },
          isOn: currentValue == _getKeyName('large'),
        ),
        TextstyleButtonQuill(
          icon: '14',
          noIcon: true,
          onTap: () {
            const newValue = 'huge';

            final keyName = _getKeyName(newValue);
            setState(() {
              if (keyName != context.loc.clear) {
                currentValue = keyName ?? _defaultDisplayText;
              } else {
                currentValue = _defaultDisplayText;
              }
              if (keyName != null) {
                controller.formatSelection(
                  Attribute.fromKeyValue(
                    Attribute.size.key,
                    newValue == '0' ? null : getFontSize(newValue),
                  ),
                );
                options.onSelected?.call(newValue);
              }
            });
          },
          isOn: currentValue == _getKeyName('huge'),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    final hasFinalWidth = options.width != null;
    return Padding(
      padding: options.padding ?? const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Row(
        mainAxisSize: !hasFinalWidth ? MainAxisSize.min : MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          UtilityWidgets.maybeWidget(
            enabled: hasFinalWidth,
            wrapper: (child) => Expanded(child: child),
            child: Text(
              getLabel(currentValue) ?? '',
              overflow: options.labelOverflow,
              style: options.style ??
                  TextStyle(
                    fontSize: iconSize / 1.15,
                  ),
            ),
          ),
          Icon(
            Icons.arrow_drop_down,
            size: iconSize * iconButtonFactor,
          )
        ],
      ),
    );
  }
}
