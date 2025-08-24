import 'package:droplet/core/extensions/localization_extension%20.dart';
import 'package:droplet/core/text/app_text.dart';
import 'package:flutter/material.dart';

class OauthOrRowWidget extends StatelessWidget {
  final bool isLogin;
  const OauthOrRowWidget({super.key, this.isLogin = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Expanded(child: Divider(thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            isLogin ? context.loc.orLoginWith : context.loc.orRegisterWith,
            style: AppText.bodyMuted,
          ),
        ),
        const Expanded(child: Divider(thickness: 1)),
      ],
    );
  }
}
