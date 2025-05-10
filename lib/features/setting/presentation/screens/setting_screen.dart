import 'package:flutter/material.dart';
import '../../../../core/data/local/storage_helper.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          StorageHelper.getAccessToken() ?? '',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
