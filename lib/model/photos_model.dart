class photosModel{
  String imgSrc;
  String photoName;
  photosModel({
   required this.imgSrc,
   required this.photoName,
});
  static fromApitoApp(Map<String , dynamic>photoMap){
  return photosModel(
    photoName: photoMap["photographer"],
    imgSrc: (photoMap["src"])["portrait"]);
  }
}