import 'package:flutter/material.dart';
import 'package:chat_app/constants/constants.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);
  // color mauve as const
  static const Color mauve = AppColors.mauve;
  // turn static to const

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.crust,
      child: const Center(
        child: CircularProgressIndicator(
          color: mauve,
        ),
      ),
    );
  }
}
