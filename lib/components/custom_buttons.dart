import 'package:flutter/material.dart';

class CustomPrimaryButton extends StatelessWidget {
  const CustomPrimaryButton({super.key, required this.onTap, required this.text});

  final Function onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Ink(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFFB81D27),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}


class CustomSecondaryButton extends StatelessWidget {
  const CustomSecondaryButton({super.key, required this.onTap, required this.text});

  final Function onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Ink(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black),
        ),
        child: Text(
          text,
          style: TextStyle(color: Color(0xFFB81D27)),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

