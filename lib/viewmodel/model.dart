class Homes {
  int? id;
  String? imageUrl;
  String? city;
  String? country;
  String? description;
  String? rating;
  String? prices;

  Homes(
      {required this.id,
      required this.imageUrl,
      required this.city,
      required this.country,
      required this.description,
      required this.rating,
      required this.prices});

  Homes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    city = json['city'];
    country = json['country'];
    description = json['description'];
    rating = json['rating'];
    prices = json['prices'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['imageUrl'] = imageUrl;
    data['city'] = city;
    data['country'] = country;
    data['description'] = description;
    data['rating'] = rating;
    data['prices'] = prices;
    return data;
  }
}
