class Drill {
  final int id;
  final String sport;
  final String type;
  final String level;
  final String name;
  final List<String> tags;
  final String? banner;
  final String? directions;

  Drill({
    required this.id,
    required this.sport,
    required this.type,
    required this.level,
    required this.name,
    required this.tags,
    this.banner,
    this.directions,
  });


}
