import 'package:flutter/material.dart';
import 'package:shimarin_chill/widgets/app_bar/df_appbar.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
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
          child: const Column(
            children: [],
          ),
        )),
      ),
    );
  }
}
