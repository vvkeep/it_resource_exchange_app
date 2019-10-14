import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/common/constant.dart';
import 'package:it_resource_exchange_app/model/movie_info.dart';
import 'package:video_player/video_player.dart';
import 'video_player_widget.dart';
class VideoPlayerPage extends StatefulWidget {

  final MovieInfo movieInfo;

  const VideoPlayerPage({Key key, this.movieInfo}) : super(key: key);

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(this.widget.movieInfo.playUrl ?? "");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.movieInfo.movieName ?? ""),
      ),
      body: Column(
      
        children: <Widget>[
          VideoPlayerWidget(videoPlayerController: _videoPlayerController,),
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            children: <Widget>[
              Text('导演:${this.widget.movieInfo.director}', style: TextStyle(color: AppColors.DarkTextColor, fontSize: 16)),
              Text('演员:${this.widget.movieInfo.rolesNames}', style: TextStyle(color: AppColors.DarkTextColor, fontSize: 16)),
              Text('上映时间:${this.widget.movieInfo.releaseYear}', style: TextStyle(color: AppColors.DarkTextColor, fontSize: 16)),
              SizedBox(height: 20,),
              Text('剧情描述:', style: TextStyle(color: AppColors.DarkTextColor, fontSize: 16)),
              Text(this.widget.movieInfo.desc, style: TextStyle(color: AppColors.MidTextColor, fontSize: 14)) ,
            ],
          ),
        ],
      ),
    );
  }
}


