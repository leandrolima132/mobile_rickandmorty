import 'package:flutter/material.dart';

/// Utilitário para cores e formatação de personagens
class CharacterUtils {
  /// Retorna a cor baseada no status do personagem
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return const Color(0xFF4CAF50);
      case 'dead':
        return const Color(0xFFF44336);
      default:
        return Colors.grey;
    }
  }

  /// Formata data para exibição
  static String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
