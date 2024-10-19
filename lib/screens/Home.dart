import 'package:flutter/material.dart';
import 'package:omshribhakti/utils/Colors.dart';
import 'package:omshribhakti/widgets/wallet.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  static const double sideGaps=8.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //App bar with wallet
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: sideGaps),
                child: Row(
                  children: [
                    SizedBox(
                        width: MediaQuery.sizeOf(context).width*0.125,
                        child: Image.asset("images/app_icon.png")
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                        width: MediaQuery.sizeOf(context).width*0.25,
                        child: Image.asset("images/logo_text.png")
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width*0.1,
                    ),
                    Expanded(child: wallet())
                  ],
                ),
              ),
              // profile section
              Row(
                children: [
                  Text("Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: AppTheme.primary
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
