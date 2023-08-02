import 'package:flutter/material.dart';

class GlobalTextField extends StatefulWidget {
   GlobalTextField({
    Key? key,
    required this.hintText,
    required this.keyboardType,
    required this.textInputAction,
    required this.textAlign,
    this.obscureText = false,
    required this.controller,
    required this.title,  this.maxLine = 1,
  }) : super(key: key);

  final String title;
  final String hintText;
  int maxLine;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextAlign textAlign;
  final bool obscureText;
  final TextEditingController controller;

  @override
  State<GlobalTextField> createState() => _GlobalTextFieldState();
}

class _GlobalTextFieldState extends State<GlobalTextField> {
  bool isTap = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 5),
        TextField(
          maxLines: widget.maxLine,
          controller: widget.controller,
          obscureText: widget.hintText=="Password"?isTap:widget.obscureText,
          cursorColor: Colors.deepPurpleAccent,
          keyboardType: widget.keyboardType,
          style: Theme.of(context).textTheme.titleMedium,
          decoration: InputDecoration(
            prefixIcon: widget.hintText == "Email"
                ? const Icon(Icons.email)
                : widget.hintText == "Password"
                    ? const Icon(Icons.key)
                    : widget.hintText == "Username"
                        ? const Icon(Icons.person)
                        : null,
            suffixIcon: widget.hintText == "Password"
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isTap = !isTap;
                      });
                    },
                    icon: isTap
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  )
                : null,
            hintText: widget.hintText,
            hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.grey,
                ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide:
                  const BorderSide(width: 0.8, color: Colors.deepPurpleAccent),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(width: 0.8, color: Colors.redAccent),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide:
                  const BorderSide(width: 0.8, color: Colors.deepPurpleAccent),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(width: 0.8, color: Colors.red),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(width: 1, color: Colors.deepPurple),
            ),
          ),
        )
      ],
    );
  }
}
