import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nas/core/constant/theme.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String? value;
  final double? width;

  final String hint;
  final void Function(String?)? onChanged;
  const CustomDropdown({
    super.key,
    required this.items,
    required this.hint,
    required this.onChanged,
    this.value,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveValue = items.contains(value) ? value : null;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 32.h,
          width: width ?? 50.w,
          // Increased heig32ht
          constraints: BoxConstraints(
            maxWidth: 150.w, // Maximum width
            minWidth: 50.w, // Minimum width
          ),
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.white, width: 2.w),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: effectiveValue,
              dropdownColor: AppTheme.primaryColor,

              isExpanded: true,
              items:
                  items.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                        child: FittedBox(
                          child: Text(
                            value,
                            // style: TextStyle(color: AppTheme.white, fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
              onChanged: onChanged,

              style: TextStyle(color: AppTheme.white, fontSize: 13.sp),
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
        );
      },
    );
  }
}
