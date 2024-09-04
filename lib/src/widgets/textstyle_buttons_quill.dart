import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TextstyleButtonQuill extends StatelessWidget {
  const TextstyleButtonQuill(
      {required this.icon,
      required this.onTap,
      super.key,
      this.width = 5,
      this.isOn = false,
      this.isColorPicker = false,
      this.noIcon = false});

  final String icon;
  final Function() onTap;
  final double width;
  final bool isOn;
  final bool isColorPicker;
  final bool noIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 30.w,
          height: 30.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20.r),
            ),
            color: isOn
                ? Theme.of(context).brightness == Brightness.light
                    ? const Color(0xFF474747)
                    : const Color(0xFFF6F6F6)
                : Colors.transparent,
          ),
          child: noIcon
              ? Center(
                  child: Text(
                    icon,
                    style: isOn
                        ? Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).brightness == Brightness.light
                                ? Colors.white
                                : const Color(0xFF3a3a3a))
                        : Theme.of(context).textTheme.bodySmall,
                  ),
                )
              : SvgPicture.asset(
                  icon,
                  fit: BoxFit.scaleDown,
                  colorFilter: isColorPicker
                      ? null
                      : ColorFilter.mode(
                          isOn
                              ? Theme.of(context).brightness == Brightness.light
                                  ? Colors.white
                                  : const Color(0xFF3a3a3a)
                              : Theme.of(context).textTheme.headlineSmall!.color!,
                          BlendMode.srcIn),
                ),
        ),
      ),
    );
  }
}
