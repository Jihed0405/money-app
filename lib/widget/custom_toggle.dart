import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CustomToggle extends StatefulWidget {
  final String text;
  final bool isSelected;
  final Color bgColor;

  const CustomToggle(
      {Key? key,
      required this.text,
      this.isSelected = false,
      this.bgColor = Colors.green})
      : super(key: key);
  @override
  _CustomToggleState createState() => _CustomToggleState();
}

class _CustomToggleState extends State<CustomToggle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 60,
      decoration: BoxDecoration(
        gradient: widget.isSelected
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [
                    0.1,
                    0.15,
                    0.4,
                    0.8,
                  ],
                colors: [
                    Color(0xFF35a6e5),
                    Color(0xFF42a0e8),
                    Color(0xFFd676db),
                    Color(0xFFf88568)
                  ])
            : LinearGradient(colors: [background, Colors.white]),
        border: widget.isSelected
            ? Border.all(
                //color: const Color.fromARGB(255, 18, 32, 47),
                color: Colors.transparent,
              )
            : null,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Center(
        child: widget.isSelected
            ? Text(widget.text,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white))
            : Text(widget.text,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.black)),
      ),
    );
  }
}
