import 'package:flutter/material.dart';

class PlayerData {
  final String name;
  final String imageUrl;

  const PlayerData({required this.name, required this.imageUrl});
}

const List<Color> _avatarPalette = [
  Color(0xFF7C3AED),
  Color(0xFF2563EB),
  Color(0xFF16A34A),
  Color(0xFFEA580C),
  Color(0xFFDB2777),
  Color(0xFF0891B2),
  Color(0xFFA16207),
];

Color avatarColorForIndex(int index) {
  if (index < 0) return _avatarPalette.first;
  return _avatarPalette[index % _avatarPalette.length];
}

String initialsFromName(String name) {
  final trimmed = name.trim();
  if (trimmed.isEmpty) return '??';
  final runes = trimmed.runes.toList();
  final first = String.fromCharCode(runes.first).toUpperCase();
  final last = String.fromCharCode(runes.last).toUpperCase();
  return '$first$last';
}

Color avatarColorFromName(String name) {
  final key = name.trim().toLowerCase();
  final index = key.isEmpty ? 0 : key.hashCode.abs() % _avatarPalette.length;
  return _avatarPalette[index];
}

const List<PlayerData> kDemoPlayers = [
  PlayerData(
    name: 'Stephen',
    imageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
  ),
  PlayerData(
    name: 'Alice',
    imageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
  ),
  PlayerData(
    name: 'Samuel',
    imageUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
  ),
  PlayerData(
    name: 'Tony',
    imageUrl: 'https://randomuser.me/api/portraits/men/4.jpg',
  ),
];
