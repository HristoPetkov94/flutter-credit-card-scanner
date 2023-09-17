import 'package:credit_card_scanner/credit_card_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card_scanner/success_page/success_page.dart';
import 'package:flutter_credit_card_scanner/utils/validation_utils.dart';

import 'widgets/credit_card_widget.dart';

class CreditCardPage extends StatefulWidget {
  const CreditCardPage({super.key});

  @override
  State<CreditCardPage> createState() => _CreditCardPageState();
}

class _CreditCardPageState extends State<CreditCardPage> {
  final _formKey = GlobalKey<FormState>();
  final _scanOptions = const CardScanOptions(
      scanCardHolderName: true,
      scanExpiryDate: true,
      validCardsToScanBeforeFinishingScan: 5,
      possibleCardHolderNamePositions: [
        CardHolderNameScanPosition.belowCardNumber
      ]);

  var _cardName = 'XXXXXX XXXXXX';
  var _cardNumber = 'XXXX-XXXX-XXXX-XX';
  var _cardExpDate = 'XX/XX';
  var _cvv = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 450,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            creditCard(_cardName, _cardNumber, _cardExpDate),
            _creditCardFormFields(),
            _buttons(),
          ],
        ),
      ),
    );
  }

  void _submitButton() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {});

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const SuccessPage(),
        ),
      );
    }
  }

  void _scanButton() async {
    final cardDetails = await CardScanner.scanCard(scanOptions: _scanOptions);

    if (!mounted || cardDetails == null) return;
    setState(() {
      _cardNumber = cardDetails.cardNumber;
      _cardName = cardDetails.cardHolderName;
      _cardExpDate = cardDetails.expiryDate;
      _cardNumber = cardDetails.cardIssuer;
    });
  }

  Widget _creditCardFormFields() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _cardNameTextFormField(),
          _cardNumberTextFormField(),
          _cardDateAndCvvTextFormFields()
        ],
      ),
    );
  }

  Widget _cardNameTextFormField() {
    return TextFormField(
      key: const Key('cardNameField'),
      maxLength: 25,
      decoration: const InputDecoration(labelText: 'Card Holder Name'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the card holder name.';
        }
        return null;
      },
      onSaved: (value) {
        _cardName = value!;
      },
    );
  }

  Widget _cardNumberTextFormField() {
    return TextFormField(
      key: const Key('cardNumberField'),
      maxLength: 16,
      decoration: const InputDecoration(
        labelText: 'Card Number',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a card number.';
        } else if (!ValidationUtils.isNumeric(value)) {
          return 'Card number should only contain numeric digits.';
        } else if (value.length < 16) {
          return 'Card number should be 16 digits long.';
        }
        return null;
      },
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
      onSaved: (value) {
        _cardNumber = value!.trim();
      },
    );
  }

  Widget _cardDateAndCvvTextFormFields() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: TextFormField(
            key: const Key('dateFormField'),
            maxLength: 5,
            decoration: const InputDecoration(
              labelText: 'Expiry Date (MM/YY)',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the expiry date.';
              } else if (!ValidationUtils.isValidExpiryDate(value)) {
                return 'Invalid expiry date format. Use MM/YY.';
              }
              return null;
            },
            onSaved: (value) {
              _cardExpDate = value!;
            },
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 1,
          child: TextFormField(
            key: const Key('cardCvvField'),
            maxLength: 3,
            decoration: const InputDecoration(
              labelText: 'CVV',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a CVV.';
              } else if (!ValidationUtils.isNumeric(value)) {
                return 'CVV should be numeric value.';
              }
              return null;
            },
            onSaved: (value) {
              _cvv = value!;
            },
          ),
        ),
      ],
    );
  }

  Widget _buttons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: ElevatedButton.icon(
            onPressed: _scanButton,
            icon: const Icon(Icons.camera_alt, size: 32),
            label: const Text('Scanner', style: TextStyle(fontSize: 20)),
            style: _buttonStyle(),
          ),
        ),
        const SizedBox(width: 14),
        Flexible(
          child: ElevatedButton.icon(
            onPressed: _submitButton,
            icon: const Icon(Icons.check, size: 32),
            label: const Text('Submit', style: TextStyle(fontSize: 20)),
            style: _buttonStyle(),
          ),
        ),
      ],
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
    );
  }
}
