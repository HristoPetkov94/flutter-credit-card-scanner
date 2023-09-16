import 'package:flutter/material.dart';
import 'credit_card_page/credit_card_page.dart';

class CreditCardScanner extends StatelessWidget {
  const CreditCardScanner({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Credit Card Scanner'),
        ),
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 253, 253, 253),
                Color.fromARGB(255, 143, 149, 183),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const CreditCardPage(),
        ),
      ),
    );
  }
}
