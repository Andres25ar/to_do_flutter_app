import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const FilterButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,

      child: ElevatedButton(
        onPressed: onPressed,

        style: ButtonStyle(
          // color dinámico según estado
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (states) {
              if (isSelected) {
                return Colors.deepPurple;
              }
              if (states.contains(MaterialState.pressed)) {
                return Colors.deepPurple.shade200;
              }
              return Colors.grey.shade200;
            },
          ),

          // color de texto
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (states) {
              if (isSelected) return Colors.white;
              return Colors.black87;
            },
          ),

          // padding
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 12),
          ),

          // bordes redondeados
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          // sombra leve si está seleccionado
          elevation: MaterialStateProperty.resolveWith<double>(
                (states) {
              if (isSelected) return 4;
              return 0;
            },
          ),
        ),

        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}