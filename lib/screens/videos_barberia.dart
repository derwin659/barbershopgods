import 'package:barberia/model/VideoModel.dart';
import 'package:barberia/screens/user_history_screen.dart';
import 'package:chewie/chewie.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../cloud_firestore/all_video_barber.dart';
import '../services/chewiList.dart';
import 'booking_screen.dart';
import 'home_screen.dart';

class VideosBarber extends StatefulWidget {
  const VideosBarber({Key? key}) : super(key: key);

  @override
  State<VideosBarber> createState() => _VideosBarberState();
}

class _VideosBarberState extends State<VideosBarber> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "Lista de videos",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
            child: SingleChildScrollView(
                physics: new BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  FutureBuilder(
                      future: getVideos(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          var videos = snapshot.data as List<VideoModel>;
                          return SingleChildScrollView(
                            physics: new BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListView.separated(
                                    shrinkWrap: true,
                                    cacheExtent: 1000,
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    addAutomaticKeepAlives: true,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: double.infinity,
                                        height: 350.0,
                                        alignment: Alignment.center,
                                        child: Container(
                                          color: Colors.black,
                                            child: ChewieLisItemState(
                                                true,
                                                VideoPlayerController.network(
                                                    videos[index].video))
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return Divider(color: Colors.white,);
                                    },
                                    itemCount:
                                        videos.isEmpty ? 0 : videos.length)
                              ],
                            ),
                          );
                        }
                      })
                ]))));
  }



}
