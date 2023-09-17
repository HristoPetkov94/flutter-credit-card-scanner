import 'package:flutter/material.dart';
import 'package:flutter_credit_card_scanner/utils/validation_utils.dart';

Widget creditCard(String cardName, String cardNumber, String expDate) {
  return Container(
    width: 350,
    height: 200,
    decoration: _boxDecoration(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Image(
                  image: AssetImage('assets/logos/techpods_logo.png'),
                  width: 85,
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Text(
                  'Credit Card',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Expanded(
              flex: 1,
              child: Image(
                image: AssetImage('assets/chip.png'),
                height: 50,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                _getCardNumber(cardNumber),
                style: const TextStyle(color: Colors.white, fontSize: 22),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: Text(
                cardName,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Flexible(
              child: Text(
                'THRU - $expDate',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const Image(
              image: AssetImage('assets/logos/master_card_logo.png'),
              width: 70,
              height: 70,
            ),
          ],
        )
      ],
    ),
  );
}

String _getCardNumber(String cardNumber) {
  return cardNumber.contains('X')
      ? cardNumber
      : ValidationUtils.formatCardNumber(cardNumber);
}

BoxDecoration _boxDecoration() {
  return BoxDecoration(
    color: Colors.redAccent,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 10,
          offset: const Offset(0, 3))
    ],
  );
}
