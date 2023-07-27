class ListTrabajosRealizados{
  late String foto;
  late String name;


  ListTrabajosRealizados({required this.foto,required this.name});


  ListTrabajosRealizados.fromJson(Map<String,dynamic> json){
    foto = json['foto'];
    name = json['name'];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = <String,dynamic>{};
    data['foto'] = foto;
    data['name'] = name;


    return data;
  }
}