class ImageModel {
  ImageModel({
    required this.originalname,
    required this.filename,
  });

  String originalname;
  String filename;

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        originalname: json["originalname"],
        filename: json["filename"],
      );

  Map<String, dynamic> toJson() => {
        "originalname": originalname,
        "filename": filename,
      };
}
