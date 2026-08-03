import '../../../../core/utils/app_imports.dart';


class RememberMeRow extends StatefulWidget {
  const RememberMeRow({
    super.key,
    required onForgotPasswordPressed,
  }) : _onForgotPasswordPressed = onForgotPasswordPressed;

  final VoidCallback _onForgotPasswordPressed;

  @override
  State<RememberMeRow> createState() => _RememberMeRowState();
}

class _RememberMeRowState extends State<RememberMeRow> {
  bool _rememberMe = false;

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Coming soon')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: AppDimensions.iconLg,
          height: AppDimensions.iconLg,
          child: Checkbox(
            value: _rememberMe,
            activeColor: AppColors.accentCyan,
            checkColor: AppColors.loginBackground,
            side: const BorderSide(color: AppColors.textOnColor, width: AppDimensions.borderWidth),
            onChanged: (val) {
              setState(() {
                _rememberMe = val ?? false;
              });
              _showComingSoon(context);
            },
          ),
        ),
        const SizedBox(width: AppDimensions.spaceSm),
        Text(
          'Remember me',
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textOnColor),
        ),
        const Spacer(),
        TextButton(
          onPressed: widget._onForgotPasswordPressed,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Forgot your password?',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textOnColor,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.textOnColor,
            ),
          ),
        ),
      ],
    );
  }
}
