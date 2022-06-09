import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';
import 'dart:async';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final Telephony telephony = Telephony.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          child: Center(
            child: Container(
              height: 370,
              width: 370,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(500),
              ),
              child: const Center(
                child: Text(
                  'Nesecito ayuda',
                  style: TextStyle(fontSize: 35, color: Colors.white),
                ),
              ),
            ),
          ),
          onTap: () async {
            await telephony.requestPhonePermissions;

            telephony.sendSms(to: "+5353519709", message: "Nesecito ayuda");

            var timer = Timer(const Duration(seconds: 20), () async {
              await telephony.dialPhoneNumber("+5353519709");
            });

            telephony.listenIncomingSms(
                onNewMessage: (SmsMessage message) {
                  timer.cancel();
                },
                listenInBackground: false);
          }),
    );
  }
}
