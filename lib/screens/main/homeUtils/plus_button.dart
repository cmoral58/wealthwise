import 'package:flutter/material.dart';

class PlusButton extends StatelessWidget {
  final function;

  const PlusButton({super.key, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          shape: BoxShape.circle,
          boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade500,
                  offset: const Offset(4.0, 4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0),
              const BoxShadow(
                  color: Colors.white,
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0),
            ]
        ),
        child: Center(
          child: Text(
            '+',
            style: TextStyle(color: Colors.grey[800], fontSize: 26),
            
          ),
        ),
      ),
    );
  }
}