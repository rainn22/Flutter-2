import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/theme/theme.dart';

class RidePrefInputTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  final bool isPlaceHolder;

  const RidePrefInputTile({super.key, required this.icon, required this.title, required this.onTap, this.isPlaceHolder = false});

  @override
  Widget build(BuildContext context) {
    Color textColor =
        isPlaceHolder ? BlaColors.textLight : BlaColors.textNormal;
        
    return ListTile(
      leading: Icon(
        icon,
        color: BlaColors.iconLight,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: textColor
        ),
      ),
      onTap: onTap, 
    );
  }
}