// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors

import'package:flutter/material.dart';

class Options extends StatefulWidget {
  final int index;
  final VoidCallback onTap;
  final bool isCorrect;
  final bool isEnabled;
  final bool isWrongSelected;

  Options({
    required this.index,
    required this.onTap,
    required this.isCorrect,
    required this.isEnabled,
    required this.isWrongSelected,
  });

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  bool isSelected = false;

  @override
  void didUpdateWidget(Options oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isEnabled != widget.isEnabled && widget.isEnabled) {
      setState(() {
        isSelected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isEnabled
          ? () {
              widget.onTap();
              setState(() {
                isSelected = true;
              });
            }
          : null,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: isSelected
              ? widget.isCorrect
                  ? Colors.green
                  : widget.isWrongSelected
                      ? Colors.red
                      : Colors.white
              : Colors.white,
        ),
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.height * 0.4,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
          child: Text("${widget.index}"),
        ),
      ),
    );
  }
}
