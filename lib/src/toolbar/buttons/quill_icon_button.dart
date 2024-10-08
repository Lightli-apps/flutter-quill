import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/quill_icon_theme.dart';

class QuillToolbarIconButton extends StatelessWidget {
  const QuillToolbarIconButton({
    required this.onPressed,
    required this.icon,
    required this.isSelected,
    required this.iconTheme,
    this.afterPressed,
    this.tooltip,
    super.key,
  });

  final VoidCallback? onPressed;
  final VoidCallback? afterPressed;
  final Widget icon;

  final String? tooltip;
  final bool isSelected;

  final QuillIconTheme? iconTheme;

  @override
  Widget build(BuildContext context) {
    log('QUILL_TOOLBAR_ICON_BUTTON: ${icon.toString().substring(51, 100)}');
    return InkWell(
      splashColor: Theme.of(context).brightness == Brightness.light ? const Color(0xFF474747) : const Color(0xFFF6F6F6),
      onTap: onPressed != null
          ? () {
              onPressed?.call();
              afterPressed?.call();
            }
          : null,
      child: Container(
        width: 30.w,
        height: 30.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20.r),
          ),
          color: isSelected
              ? Theme.of(context).brightness == Brightness.light
                  ? const Color(0xFF474747)
                  : const Color(0xFFF6F6F6)
              : Colors.transparent,
        ),
        child: icon,
      ),
    );
  }
}
