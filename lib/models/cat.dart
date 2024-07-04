class Cat {
  final String id;
  final String name;
  final String origin;
  final int energyLevel;
  final String description;
  final String temperament;
  final int intelligence;
  final String img;

  Cat({
    required this.id,
    required this.name,
    required this.origin,
    required this.energyLevel,
    required this.description,
    required this.temperament,
    required this.intelligence,
    required this.img,
  });

  Cat.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        name = json['name'] ?? 'Unknown',
        origin = json['origin'] ?? 'Unknown',
        energyLevel = json['energy_level'] ?? 0,
        description = json['description'] ?? 'No description available.',
        temperament = json['temperament'] ?? 'Unknown',
        intelligence = json['intelligence'] ?? 0,
        img = json['reference_image_id'] ?? '';

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'origin': origin,
        'energy_level': energyLevel,
        'description': description,
        'temperament': temperament,
        'intelligence': intelligence,
        'reference_image_id': img,
      };
}

class FavoriteCats {
  final String id;
  final String name;
  final String temperament;
  final int intelligence;
  final String img;

  FavoriteCats.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        temperament = map['temperament'],
        intelligence = map['intelligence'],
        img = map['reference_image_id'];
}
