import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChewieLisItemState extends StatefulWidget{

  bool looping;
  VideoPlayerController videoPlayerController;


  ChewieLisItemState(this.looping, this.videoPlayerController);


  @override
  _ChewieLisItemState createState() => _ChewieLisItemState();
}


class _ChewieLisItemState extends State<ChewieLisItemState>{
    late final ChewieController _chewieController;

  @override
  void initState(){
    super.initState();

    _chewieController= ChewieController(
        videoPlayerController: widget.videoPlayerController,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.lightBlue,
          handleColor: const Color(0xFFEBBEA7),
          backgroundColor: Colors.red,
          bufferedColor: Colors.lightGreen
        ),
        aspectRatio: 3/2,
        autoInitialize: true,
        autoPlay: true,
        looping: widget.looping,
        errorBuilder: (context,errorMessage){
          return Center(
            child: Text(
              errorMessage,
              style: TextStyle(color: Colors.white),
            ),
          );
        },


    );

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   Chewie(
        controller: _chewieController,
      );

  }
  @override
  void dispose() {

    widget.videoPlayerController!.dispose();
    _chewieController.dispose();
    super.dispose();
  }

}
