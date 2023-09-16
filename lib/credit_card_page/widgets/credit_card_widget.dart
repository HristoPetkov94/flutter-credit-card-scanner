import 'package:flutter/material.dart';
import 'package:flutter_credit_card_scanner/utils/validation_utils.dart';

Widget creditCard(String cardName, String cardNumber, String expDate) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Container(
      width: 450,
      height: 250,
      decoration: _boxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Image(
                  image: AssetImage('assets/logos/techpods_logo.png'),
                  width: 100,
                ),
              ),
              Padding(
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
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Image(
                image: AssetImage('assets/chip.png'),
                width: 50,
                height: 100,
              ),
              Text(
                _getCardNumber(cardNumber),
                style: const TextStyle(color: Colors.white, fontSize: 30),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                cardName,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                'THRU - $expDate',
                style: const TextStyle(
                  color: Colors.white,
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