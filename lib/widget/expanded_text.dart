import 'package:flutter/material.dart';
import 'package:restaurant_app/constant/style.dart';

class ExpandedText extends StatefulWidget {
  final String text;
  const ExpandedText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<ExpandedText> createState() => _ExpandedTextState();
}

class _ExpandedTextState extends State<ExpandedText> {
  late String firstHalf;
  late String secondHalf;
  bool isExpanded = true;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > 100) {
      firstHalf = widget.text.substring(0, 150);
      secondHalf = widget.text.substring(151, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: unrelated_type_equality_checks
      child: secondHalf.length == ""
          ? Text(widget.text)
          : Column(
              children: [
                Text(
                  isExpanded ? firstHalf : widget.text,
                ),
                const SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: Row(
                    children: [
                      isExpanded
                          ? const Text(
                              "Show more",
                              style: TextStyle(
                                color: secondaryColor,
                              ),
                            )
                          : const Text(
                              "Show less",
                              style: TextStyle(
                                color: secondaryColor,
                              ),
                            ),
                      Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up,
                        color: secondaryColor,
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
