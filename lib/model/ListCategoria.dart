class ListCategorias{
  late String imagen;
  late int precio;


  ListCategorias({required this.imagen,required this.precio});


  ListCategorias.fromJson(Map<String,dynamic> json){
    imagen = json['imagen'];
    precio = int.parse(json['precio']==null ? '-1':json['precio'].toString());
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = <String,dynamic>{};
    data['imagen'] = imagen;
    data['precio'] = precio;

    return data;
  }
}