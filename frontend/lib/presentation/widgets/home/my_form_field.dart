import 'package:flutter/material.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';

class MyFormField extends StatelessWidget {
  final String hintText;

  final bool isObsecure;

  const MyFormField({
    super.key,
    required this.hintText,
    required this.isObsecure,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(.01),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: TextField(
          obscureText: isObsecure,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: textTheme.bodySmall!.copyWith(color: Colors.grey),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.grey[200],
            suffixIcon: IconButton(
              onPressed: () {},
              icon: isObsecure
                  ? const Icon(
                      Icons.visibility,
                    )
                  : const SizedBox(),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
          ),
        ),
      ),
    );
  }
}
