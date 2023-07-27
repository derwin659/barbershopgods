class VideoModel{
  late String video;

  VideoModel({required this.video});


  VideoModel.fromJson(Map<String,dynamic> json){
    video=json['video'];

  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data=new Map<String,dynamic>();


    data['video']=this.video;


    return data;
  }
}