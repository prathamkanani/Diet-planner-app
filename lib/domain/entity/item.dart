/// A selectable item to be shown in the UI. (shown in selectable chip in the UI).
class Item {
  final int id;
  final String title;
  final String subtitle;
  final bool isSubtitle;

  const Item({
    required this.id,
    required this.title,
    this.subtitle = '',
    this.isSubtitle = false,
  });
}
