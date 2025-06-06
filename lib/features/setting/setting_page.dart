import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shimarin_chill/features/setting/bloc/setting_bloc.dart';
import 'package:shimarin_chill/features/setting/components/setting_item_view.dart';
import 'package:shimarin_chill/utils/app_icon.dart';
import 'package:shimarin_chill/widgets/app_bar/df_appbar.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingBloc, SettingState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: dfAppBar(
              title: "Setting",
            ),
            body: SafeArea(
                child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 16,
              ),
              child: Column(
                children: [
                  // button chuyển dark light
                  // button show dialog thông tin giới thiệu app
                  // button link chia sẻ app
                  SettingItemView(
                    title: 'Dark mode',
                    icon: FlutterSwitch(
                      value: state.isDarkMode,
                      height: 24,
                      width: 50,
                      padding: 1.5,
                      activeColor: Colors.green,
                      activeIcon: Icon(
                        AppIcons.dark,
                        color: Colors.purple,
                      ),
                      inactiveIcon: Icon(
                        AppIcons.light,
                        color: Colors.amber,
                      ),
                      onToggle: (value) {
                        context.read<SettingBloc>().add(
                              ChangedModeApp(isChanged: value),
                            );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SettingItemView(
                    title: 'Giới thiệu chung',
                    icon: Icon(AppIcons.info),
                    onTap: () {},
                  ),
                  const SizedBox(height: 16),
                  SettingItemView(
                    title: 'Chia sẻ',
                    icon: Icon(AppIcons.share),
                    onTap: () {},
                  ),
                ],
              ),
            )),
          ),
        );
      },
    );
  }
}
