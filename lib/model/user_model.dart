

class UserModel{

  late String name,email,imgUrl;
  late bool isStaff;

  UserModel({required this.isStaff,required this.name,required this.email,required this.imgUrl});

  UserModel.fromJson(Map<String,dynamic> json){
    print('modelo usuario');
    email = json['email'];
    name= json['name'];
    imgUrl = json['imgUrl'];
    isStaff = json['isStaff'] == null ? false:json['isStaff'] as bool;
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data=new Map<String,dynamic>();

    data['email']= this.email;
    data['name']=this.name;
    data['imgUrl']= this.imgUrl;
    data['isStaff']=this.isStaff;

    return data;

  }



}