class PlayerData {
  final String name;
  final String imageUrl;

  const PlayerData({required this.name, required this.imageUrl});
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
