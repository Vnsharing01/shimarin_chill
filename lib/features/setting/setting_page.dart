import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shimarin_chill/bloc/app_bloc.dart';
import 'package:shimarin_chill/features/setting/bloc/setting_bloc.dart';
import 'package:shimarin_chill/features/setting/components/setting_item_view.dart';
import 'package:shimarin_chill/utils/app_icon.dart';
import 'package:shimarin_chill/utils/app_text_style.dart';
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
      listener: (context, state) {},
      listenWhen: (previous, current) {
        if (!(previous.isDarkMode != current.isDarkMode)) {
          return false;
        }
        context.read<AppMainBloc>().add(
              ChangedThemeMode(isChanged: current.isDarkMode),
            );
        return true;
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: dfAppBar(
              title: "Cài Đặt",
            ),
            body: SafeArea(
                child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 16,
              ),
              child: Column(
                children: [
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
                      onToggle: (value) async {
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
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => _infoAppPopup(),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  // SettingItemView(
                  //   title: 'Chia sẻ',
                  //   icon: Icon(AppIcons.share),
                  //   onTap: () {},
                  // ),
                ],
              ),
            )),
          ),
        );
      },
    );
  }

  Widget _infoAppPopup() {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: Text(
        'Thông tin chung',
        textAlign: TextAlign.center,
        style: AppTextStyle.lable(),
      ),
      content: Text(
        'Ứng dụng Shimarin chill tổng hợp những bản nhạc lo-fi không lời từ pixabay.com. \nCác bản nhạc được tổng hợp theo chủ đề thích hợp cho tập trung trong công việc, học tập và thư giãn.',
        softWrap: true,
        style: AppTextStyle.body14(),
      ),
    );
  }
}
