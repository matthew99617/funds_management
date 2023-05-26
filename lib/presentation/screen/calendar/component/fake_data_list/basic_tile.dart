class BasicTile {
  final String title;
  final List<BasicTile> tiles;

  const BasicTile({
    required this.title,
    this.tiles = const [],
  });
}

final basicTiles = <BasicTile>[
  const BasicTile(
    title: 'Fruits',
    tiles: [
      BasicTile(title: 'Apple'),
      BasicTile(title: 'Orange'),
      BasicTile(title: 'Banana'),
      BasicTile(title: 'Watermelon'),
    ],
  ),
  const BasicTile(
    title: 'Continent',
    tiles: [
      BasicTile(title: 'Afghanis'),
      BasicTile(title: 'Iran'),
    ],
  ),
  const BasicTile(
    title: 'Test',
    tiles: [
      BasicTile(title: 'Testing123'),
      BasicTile(title: 'Testing1234'),
      BasicTile(title: 'Testing12345'),
      BasicTile(title: 'Testing123456'),
    ],
  ),
];