import 'package:flutter/material.dart';

class LittleAvatar extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;
  final double size;
  final String id;
  final String nombre;
  final String habilidad;
  final double? calificacion;
  final int? cantCalif;

  const LittleAvatar({
    Key? key,
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
    required this.id,
    required this.nombre,
    required this.habilidad,
    required this.calificacion,
    required this.cantCalif,
    this.size = 40.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: iconColor,
                size: size * 0.6,
              ),
              Text(
                nombre,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            habilidad,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 16,
              ),
              Text(
                calificacion?.toStringAsFixed(1) ?? 'N/A',
                style: const TextStyle(fontSize: 12, color: Colors.amber),
              ),
              const SizedBox(width: 4),
              Text(
                '/ ${cantCalif ?? 0}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
