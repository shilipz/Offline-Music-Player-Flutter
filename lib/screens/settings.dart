import 'package:flutter/material.dart';

import 'miniplayer.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 239, 116, 81),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Change AppTheme',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                        color: Color.fromARGB(255, 239, 116, 81)),
                  ),
                  Icon(
                    Icons.toggle_off,
                    color: Color.fromARGB(255, 239, 116, 81),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      bottomSheet: MiniPlayer(),
    );
  }
}
