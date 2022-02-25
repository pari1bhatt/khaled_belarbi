class LatLong {
  final double? lat;
  final double? lng;
  LatLong({required this.lat, required this.lng});

  factory LatLong.fromJson(Map<String, dynamic> json) {
    return LatLong(
      lat: json['lat'] as double,
      lng: json['lng'] as double,
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}


class Region {
  final LatLong coords;
  final String id;
  final String name;
  final double zoom;
  Region({
    required this.coords,
    required this.id,
    required this.name,
    required this.zoom,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      coords: json['coords'] as LatLong,
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      zoom: json['zoom'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['coords'] = coords;
    data['id'] = id;
    data['name'] = name;
    data['zoom'] = zoom;
    return data;
  }
}