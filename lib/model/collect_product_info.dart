import 'package:json_annotation/json_annotation.dart';

part 'collect_product_info.g.dart';

@JsonSerializable()
class CollectProductInfo extends Object {

	@JsonKey(name: 'price')
	double price;

	@JsonKey(name: 'cateId')
	String cateId;

	@JsonKey(name: 'coverUrl')
	String coverUrl;

	@JsonKey(name: 'updateTime')
	int updateTime;

	@JsonKey(name: 'productId')
	int productId;

	@JsonKey(name: 'productStatus')
	int productStatus;

	@JsonKey(name: 'collectId')
	int collectId;

	@JsonKey(name: 'createdBy')
	String createdBy;

	@JsonKey(name: 'productTitle')
	String productTitle;

	@JsonKey(name: 'imgUrls')
	String imgUrls;

	@JsonKey(name: 'productAddressUrl')
	String productAddressUrl;

	@JsonKey(name: 'keywords')
	String keywords;

	@JsonKey(name: 'createdTime')
	int createdTime;

	@JsonKey(name: 'productDesc')
	String productDesc;

	@JsonKey(name: 'tradeCount')
	int tradeCount;

	@JsonKey(name: 'isDelete')
	bool isDelete;

	@JsonKey(name: 'cateTitle')
	String cateTitle;

	CollectProductInfo(this.price,this.cateId,this.coverUrl,this.updateTime,this.productId,this.productStatus,this.collectId,this.createdBy,this.productTitle,this.imgUrls,this.productAddressUrl,this.keywords,this.createdTime,this.productDesc,this.tradeCount,this.isDelete,this.cateTitle,);

	factory CollectProductInfo.fromJson(Map<String, dynamic> srcJson) => _$CollectProductInfoFromJson(srcJson);

	Map<String, dynamic> toJson() => _$CollectProductInfoToJson(this);

}
