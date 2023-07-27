class ImageModel{
  late String image;
 String? category;
  late String descripcion;

  ImageModel({required this.image,required this.category,required this.descripcion});


  ImageModel.fromJson(Map<String,dynamic> json){
    image = json['image'];
    category = json['category'];
    descripcion = json['descripcion'];


  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = <String,dynamic>{};
    data['image'] = image;
    data['category'] = category;
    data['descripcion'] = descripcion;


    return data;
  }
}