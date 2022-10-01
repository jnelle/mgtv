import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/gen/colors.gen.dart';
import 'package:mgtv/ui/hooks/use_router.dart';
import 'package:mgtv/ui/route/app_route.dart';
import 'package:mgtv/ui/user_view_model.dart';
import 'package:sized_context/sized_context.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserViewModel userViewModel = ref.watch(userViewModelProvider);
    StackRouter router = useRouter();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorName.primaryColor,
        title: Text(
          'Einstellungen',
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: context.widthPct(0.055),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SettingsList(
          platform:
              Platform.isAndroid ? DevicePlatform.android : DevicePlatform.iOS,
          sections: <AbstractSettingsSection>[
            SettingsSection(
              tiles: <AbstractSettingsTile>[
                SettingsTile.switchTile(
                  onToggle: (bool value) => userViewModel.onlyVideo = value,
                  initialValue: userViewModel.onlyVideo,
                  leading: const Icon(Icons.video_library),
                  title: const Text('Nur Videos abspielen'),
                  description: const Text(
                    'Legt fest ob nur Videos oder Audios abgespielt werden sollen',
                  ),
                ),
              ],
            ),
            SettingsSection(
              tiles: <AbstractSettingsTile>[
                SettingsTile(
                  leading: const Icon(Icons.logout_outlined),
                  title: const Text('Abmelden'),
                  onPressed: (BuildContext context) {
                    userViewModel.logout();
                    router.replace(const Login());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
