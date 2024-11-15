
import 'package:flutter/material.dart';

class MyHomeHeader extends StatelessWidget {
  final String headerLabel;

  const MyHomeHeader({
    super.key, required this.headerLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            headerLabel,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.black,
                ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.widgets_rounded,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
