import 'package:flutter/material.dart';

class ProgressStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const ProgressStat({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 32, color: const Color(0xFF6E48AA)),
        const SizedBox(height: 8),
        Text(value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
      ],
    );
  }
}
