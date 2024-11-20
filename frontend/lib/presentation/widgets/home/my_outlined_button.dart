import 'package:flutter/material.dart';
import 'package:khidma/main.dart';

class MyOutlinedButton extends StatelessWidget {
  final void Function() onPressed;

  final String label;

  const MyOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: const MaterialStatePropertyAll(0),
          backgroundColor: MaterialStatePropertyAll(
           Colors.white
          ),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).primaryColor, ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: Text(
          label,
          style:  TextStyle(
            color: Theme.of(context).primaryColor
          ),
        ),
      ),
    );
  }
}
