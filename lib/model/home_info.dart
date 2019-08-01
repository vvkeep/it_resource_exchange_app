import 'package:json_annotation/json_annotation.dart';

part 'home_info.g.dart';

@JsonSerializable()
class HomeInfo extends Object {

	@JsonKey(name: 'advertiseList')
	List<AdvertiseList> advertiseList;

	@JsonKey(name: 'recommendProductList')
	List<RecommendProductList> recommendProductList;

	HomeInfo(this.advertiseList,this.recommendProductList,);

	factory HomeInfo.fromJson(Map<String, dynamic> srcJson) => _$HomeInfoFromJson(srcJson);

	Map<String, dynamic> toJson() => _$HomeInfoToJson(this);

}

@JsonSerializable()
class AdvertiseList extends Object {

	@JsonKey(name: 'adId')
	int adId;

	@JsonKey(name: 'adTitle')
	String adTitle;

	@JsonKey(name: 'adDetailUrl')
	String adDetailUrl;

	@JsonKey(name: 'adProductId')
	String adProductId;

	@JsonKey(name: 'adType')
	int adType;

	@JsonKey(name: 'adCoverUrl')
	String adCoverUrl;

	AdvertiseList(this.adId,this.adTitle,this.adDetailUrl,this.adProductId,this.adType,this.adCoverUrl,);

	factory AdvertiseList.fromJson(Map<String, dynamic> srcJson) => _$AdvertiseListFromJson(srcJson);

	Map<String, dynamic> toJson() => _$AdvertiseListToJson(this);

}

@JsonSerializable()
class RecommendProductList extends Object {

	@JsonKey(name: 'coverUrl')
	String coverUrl;

	@JsonKey(name: 'cateId')
	String cateId;

	@JsonKey(name: 'productAddressPassword')
	String productAddressPassword;

	@JsonKey(name: 'imgUrls')
	String imgUrls;

	@JsonKey(name: 'keywords')
	String keywords;

	@JsonKey(name: 'price')
	double price;

	@JsonKey(name: 'productTitle')
	String productTitle;

	@JsonKey(name: 'revision')
	String revision;

	@JsonKey(name: 'productStatus')
	int productStatus;

	@JsonKey(name: 'productDesc')
	String productDesc;

	@JsonKey(name: 'recommendId')
	int recommendId;

	@JsonKey(name: 'cateTitle')
	String cateTitle;

	@JsonKey(name: 'isDelete')
	bool isDelete;

	@JsonKey(name: 'productId')
	int productId;

	@JsonKey(name: 'productAddressUrl')
	String productAddressUrl;

	@JsonKey(name: 'updateBy')
	String updateBy;

	@JsonKey(name: 'updateTime')
	int updateTime;

	@JsonKey(name: 'tradeCount')
	int tradeCount;

	@JsonKey(name: 'createdBy')
	String createdBy;

	@JsonKey(name: 'createdTime')
	int createdTime;

	RecommendProductList(this.coverUrl,this.cateId,this.productAddressPassword,this.imgUrls,this.keywords,this.price,this.productTitle,this.revision,this.productStatus,this.productDesc,this.recommendId,this.cateTitle,this.isDelete,this.productId,this.productAddressUrl,this.updateBy,this.updateTime,this.tradeCount,this.createdBy,this.createdTime,);

	factory RecommendProductList.fromJson(Map<String, dynamic> srcJson) => _$RecommendProductListFromJson(srcJson);

	Map<String, dynamic> toJson() => _$RecommendProductListToJson(this);

}
