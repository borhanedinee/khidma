import 'package:flutter/material.dart';
import 'package:khidma/presentation/pages/on_boarding_pages/on_boarding_one.dart';

class MyFormField extends StatefulWidget {
  final String hintText;

  final bool isPassword;
  final String? Function(String?)? validator;
  final TextEditingController? fieldController;
  final TextInputType? textInputType;
  final void Function(String)? onChanged;

  const MyFormField({
    super.key,
    required this.hintText,
    required this.isPassword,
    this.validator,
    this.fieldController,
    this.textInputType, this.onChanged,
  });

  @override
  State<MyFormField> createState() => _MyFormFieldState();
}

class _MyFormFieldState extends State<MyFormField> {
  bool isObsecure = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(.01),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: TextFormField(
          onChanged: widget.onChanged,
          style: textTheme.bodyMedium,
          keyboardType: widget.textInputType,
          validator: widget.validator,
          controller: widget.fieldController,
          obscureText: widget.isPassword ? isObsecure : false,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: textTheme.bodySmall!.copyWith(color: Colors.grey),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.grey[200],
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isObsecure = !isObsecure;
                      });
                    },
                    icon: isObsecure
                        ? const Icon(
                            Icons.visibility,
                          )
                        : const Icon(
                            Icons.visibility_off_rounded,
                          ))
                : null,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
          ),
        ),
      ),
    );
  }
}
