import 'package:json_annotation/json_annotation.dart';

part 'movie_info.g.dart';

@JsonSerializable()
class MovieInfo extends Object {

	@JsonKey(name: 'director')
	String director;

	@JsonKey(name: 'movieId')
	int movieId;

	@JsonKey(name: 'movieArea')
	int movieArea;

	@JsonKey(name: 'score')
	int score;

	@JsonKey(name: 'status')
	int status;

	@JsonKey(name: 'tradeCount')
	int tradeCount;

	@JsonKey(name: 'movieName')
	String movieName;

	@JsonKey(name: 'language')
	int language;

	@JsonKey(name: 'quality')
	int quality;

	@JsonKey(name: 'coverUrl')
	String coverUrl;

	@JsonKey(name: 'isDelete')
	bool isDelete;

	@JsonKey(name: 'desc')
	String desc;

	@JsonKey(name: 'rolesNames')
	String rolesNames;

	@JsonKey(name: 'releaseYear')
	String releaseYear;

	@JsonKey(name: 'playUrl')
	String playUrl;

	@JsonKey(name: 'cateId')
	String cateId;

	@JsonKey(name: 'price')
	double price;

	MovieInfo(this.director,this.movieId,this.movieArea,this.score,this.status,this.tradeCount,this.movieName,this.language,this.quality,this.coverUrl,this.isDelete,this.desc,this.rolesNames,this.releaseYear,this.playUrl,this.cateId,this.price,);

	factory MovieInfo.fromJson(Map<String, dynamic> srcJson) => _$MovieInfoFromJson(srcJson);

	Map<String, dynamic> toJson() => _$MovieInfoToJson(this);

}
