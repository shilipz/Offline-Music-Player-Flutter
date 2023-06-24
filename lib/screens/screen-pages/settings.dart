import 'package:flutter/material.dart';

import '../miniplayer.dart';

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
        backgroundColor: const Color.fromARGB(255, 239, 116, 81),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Change AppTheme',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                        color: Color.fromARGB(255, 239, 116, 81)),
                  ),
                  const Spacer(),
                  Switch(
                    activeColor: Colors.black,
                    value: true,
                    onChanged: (value) {
                      setState(() {
                        value = false;
                      });
                    },
                  )
                ],
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Privacy Policy',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                            color: Color.fromARGB(255, 239, 116, 81)),
                      )),
                  // const Spacer(),
                  // Icon(Icons.info)
                ],
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'About',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                            color: Color.fromARGB(255, 239, 116, 81)),
                      )),
                ],
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Share',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                            color: Color.fromARGB(255, 239, 116, 81)),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
      bottomSheet: const MiniPlayer(),
    );
  }
}
