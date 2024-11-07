import 'package:app_medagenda/core/constants/color.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final double? textSize;
  final double? width;
  final double? height;

  const PrimaryButton({
    Key? key,
    this.text,
    this.icon,
    this.onPressed,
    this.textStyle,
    this.textSize,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.mainSoft,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: Size(width ?? double.infinity, height ?? 36),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) Icon(icon, color: Colors.white),
          if (icon != null && text != null) SizedBox(width: 8),
          if (text != null)
            Flexible(
              child: Text(
                text!,
                style: textStyle ??
                    TextStyle(
                      color: Colors.white,
                      fontSize: textSize ?? 16,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            )
        ],
      ),
    );
  }
}
