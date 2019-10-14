// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieInfo _$MovieInfoFromJson(Map<String, dynamic> json) {
  return MovieInfo(
      json['director'] as String,
      json['movieId'] as int,
      json['movieArea'] as int,
      json['score'] as int,
      json['status'] as int,
      json['tradeCount'] as int,
      json['movieName'] as String,
      json['language'] as int,
      json['quality'] as int,
      json['coverUrl'] as String,
      json['isDelete'] as bool,
      json['desc'] as String,
      json['rolesNames'] as String,
      json['releaseYear'] as String,
      json['playUrl'] as String,
      json['cateId'] as String,
      json['price'] as double);
}

Map<String, dynamic> _$MovieInfoToJson(MovieInfo instance) => <String, dynamic>{
      'director': instance.director,
      'movieId': instance.movieId,
      'movieArea': instance.movieArea,
      'score': instance.score,
      'status': instance.status,
      'tradeCount': instance.tradeCount,
      'movieName': instance.movieName,
      'language': instance.language,
      'quality': instance.quality,
      'coverUrl': instance.coverUrl,
      'isDelete': instance.isDelete,
      'desc': instance.desc,
      'rolesNames': instance.rolesNames,
      'releaseYear': instance.releaseYear,
      'playUrl': instance.playUrl,
      'cateId': instance.cateId,
      'price': instance.price
    };
