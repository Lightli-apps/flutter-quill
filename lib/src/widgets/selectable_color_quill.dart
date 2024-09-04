import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/toolbar_assets.dart';

class SelectableColorQuill extends StatelessWidget {
  const SelectableColorQuill({
    required this.color,
    super.key,
    this.isOn = false,
    this.onClick,
    this.borderLeft = false,
    this.borderRight = false,
    this.showIcon = false,
  });

  final Color color;
  final bool isOn;
  final Function()? onClick;
  final bool borderLeft;
  final bool borderRight;
  final bool showIcon;

  @override
  Widget build(BuildContext context) => Stack(
    alignment: Alignment.center,
    children: [
      Container(
        height: isOn ? 27.h : 18.h,
        width: showIcon
            ? isOn
            ? 72.w
            : 42.w
            : isOn
            ? 42.w
            : 22.w,
        decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          borderRadius: borderLeft && !isOn
              ? BorderRadius.only(
            topLeft: Radius.circular(5.r),
            bottomLeft: Radius.circular(5.r),
          )
              : borderRight && !isOn
              ? BorderRadius.only(
            topRight: Radius.circular(5.r),
            bottomRight: Radius.circular(5.r),
          )
              : BorderRadius.all(
            Radius.circular(isOn ? 5.r : 0),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.w),
        child: GestureDetector(
          onTap: onClick,
          child: Container(
            padding: showIcon ? EdgeInsets.symmetric(vertical: 5.h) : EdgeInsets.zero,
            width: showIcon
                ? isOn
                ? 70.w
                : 40.w
                : isOn
                ? 40.w
                : 20.w,
            height: isOn ? 25.h : 16.h,
            decoration: BoxDecoration(
                borderRadius: borderLeft && !isOn
                    ? BorderRadius.only(
                  topLeft: Radius.circular(4.r),
                  bottomLeft: Radius.circular(4.r),
                )
                    : borderRight && !isOn
                    ? BorderRadius.only(
                  topRight: Radius.circular(4.r),
                  bottomRight: Radius.circular(4.r),
                )
                    : BorderRadius.all(
                  Radius.circular(isOn ? 4.r : 0),
                ),
                color: color),
            child: showIcon
                ? SvgPicture.asset(
              ToolbarAssets.fontFamilyIcon,
              fit: BoxFit.scaleDown,
              colorFilter: ColorFilter.mode(
                  borderLeft
                      ? Theme.of(context).brightness == Brightness.light
                      ? const Color(0xFF3A3A3A)
                      : Colors.white
                      : const Color(0xFF3A3A3A),
                  BlendMode.srcIn),
            )
                : const SizedBox(),
          ),
        ),
      ),
    ],
  );
}

