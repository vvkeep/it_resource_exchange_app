import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/common/constant.dart';
import 'package:it_resource_exchange_app/model/movie_info.dart';
import 'package:it_resource_exchange_app/net/network_utils.dart';
import 'package:it_resource_exchange_app/widgets/load_state_layout_widget.dart';
import 'package:video_player/video_player.dart';
import 'video_player_widget.dart';
class VideoPlayerPage extends StatefulWidget {

  final int movieId;

  const VideoPlayerPage({Key key, this.movieId}) : super(key: key);

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  VideoPlayerController _videoPlayerController;
  MovieInfo movieInfo;
    //页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  loadData() {
    NetworkUtils.requstMovieDetailData(this.widget.movieId).then((res) {
      if (res.status == 200) {
       movieInfo = MovieInfo.fromJson(res.data);
       _videoPlayerController = VideoPlayerController.network(this.movieInfo.playUrl ?? "");
        setState(() {
          _layoutState = LoadState.State_Success;
        });
      } else {
        setState(() {
          _layoutState = loadStateByErrorCode(res.status);
        });
      }
    });
  }

  Column _buildPlayerView() {
    return Column(
        children: <Widget>[
          VideoPlayerWidget(videoPlayerController: _videoPlayerController,),
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            children: <Widget>[
              Text('导演:${this.movieInfo?.director ?? ""}', style: TextStyle(color: AppColors.DarkTextColor, fontSize: 16)),
              Text('演员:${this.movieInfo?.rolesNames ?? ""}', style: TextStyle(color: AppColors.DarkTextColor, fontSize: 16)),
              Text('上映时间:${this.movieInfo?.releaseYear ?? ""}', style: TextStyle(color: AppColors.DarkTextColor, fontSize: 16)),
              SizedBox(height: 20,),
              Text('剧情描述:', style: TextStyle(color: AppColors.DarkTextColor, fontSize: 16)),
              Text(this.movieInfo?.desc ?? "", style: TextStyle(color: AppColors.MidTextColor, fontSize: 14)) ,
            ],
          ),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.movieInfo?.movieName ?? "电影详情"),
      ),
      body:  LoadStateLayout(
        state: _layoutState,
        errorRetry: () {
          setState(() {
            _layoutState = LoadState.State_Loading;
          });
          this.loadData();
        },
        successWidget: _buildPlayerView(),
      ),
      
      
    );
  }
}


