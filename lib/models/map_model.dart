
class ImageDataModel {
    String? lat;
    String? lng;
    String? path;
    String? uploaded_by;
    String? url;

    ImageDataModel({this.lat, this.lng, this.path, this.uploaded_by, this.url});

    factory ImageDataModel.fromJson(Map<String, dynamic> json) {
        return ImageDataModel(
            lat: json['lat'],
            lng: json['lng'],
            path: json['path'],
            uploaded_by: json['uploaded_by'],
            url: json['url'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['lat'] = this.lat;
        data['lng'] = this.lng;
        data['path'] = this.path;
        data['uploaded_by'] = this.uploaded_by;
        data['url'] = this.url;
        return data;
    }
}