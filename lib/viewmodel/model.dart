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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['city'] = this.city;
    data['country'] = this.country;
    data['description'] = this.description;
    data['rating'] = this.rating;
    data['prices'] = this.prices;
    return data;
  }
}
