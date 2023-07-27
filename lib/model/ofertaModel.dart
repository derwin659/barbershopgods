class OfertaModel{
  late String imagen;
  late String descripcion;

  OfertaModel({required this.imagen,required this.descripcion});


  OfertaModel.fromJson(Map<String,dynamic> json){
    imagen = json['imagen'];
    descripcion = json['descripcion'];


  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = <String,dynamic>{};
    data['imagen'] = imagen;

    data['descripcion'] = descripcion;


    return data;
  }
}