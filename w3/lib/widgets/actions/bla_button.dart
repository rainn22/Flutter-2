import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/theme/theme.dart';

enum BlaButtonType { primary, secondary }

class BlaButton extends StatelessWidget {
  final BlaButtonType type;
  final IconData? icon;
  final String label;
  final VoidCallback onPressed;

  const BlaButton({
    super.key,
    this.type = BlaButtonType.primary,
    this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPrimary = type == BlaButtonType.primary;

    Color backgroundColor = isPrimary ? BlaColors.primary : BlaColors.white;
    Color foregroundColor = isPrimary ? Colors.white : BlaColors.primary;
    Color iconColor = isPrimary ? Colors.white : BlaColors.primary;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor, backgroundColor: backgroundColor,
        side: BorderSide(
          color: isPrimary ? Colors.transparent : BlaColors.greyLight,
          width: 1,
        ),
        padding: EdgeInsets.symmetric(
          vertical: BlaSpacings.m,
          horizontal: BlaSpacings.xxl,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BlaSpacings.radius),
        ),
        textStyle: BlaTextStyles.button,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          if (icon != null) SizedBox(width: BlaSpacings.s),
          Text(
            label,
            style: BlaTextStyles.button.copyWith(
              color: foregroundColor,
            ),
          ),
        ],
      ),
    );
  }
}

//test