import 'package:json_annotation/json_annotation.dart';

part 'product_detail.g.dart';

@JsonSerializable()
class ProductDetail extends Object {

	@JsonKey(name: 'commentCount')
	int commentCount;

	@JsonKey(name: 'productDesc')
	String productDesc;

	@JsonKey(name: 'tradeCount')
	int tradeCount;

	@JsonKey(name: 'productTitle')
	String productTitle;

	@JsonKey(name: 'productStatus')
	int productStatus;

	@JsonKey(name: 'coverUrl')
	String coverUrl;

	@JsonKey(name: 'productAddressUrl')
	String productAddressUrl;

	@JsonKey(name: 'updateTime')
	int updateTime;

	@JsonKey(name: 'productAddressPassword')
	String productAddressPassword;

	@JsonKey(name: 'keywords')
	String keywords;

	@JsonKey(name: 'price')
	double price;

	@JsonKey(name: 'cateTitle')
	String cateTitle;

	@JsonKey(name: 'isDelete')
	bool isDelete;

	@JsonKey(name: 'imgUrls')
	String imgUrls;

	@JsonKey(name: 'createdTime')
	int createdTime;

	@JsonKey(name: 'createdBy')
	String createdBy;

	@JsonKey(name: 'productId')
	int productId;

	@JsonKey(name: 'cateId')
	String cateId;

  @JsonKey(name: 'collectId')
	int collectId;


	ProductDetail(this.commentCount,this.productDesc,this.tradeCount,this.productTitle,this.productStatus,this.coverUrl,this.productAddressUrl,this.updateTime,this.productAddressPassword,this.keywords,this.price,this.cateTitle,this.isDelete,this.imgUrls,this.createdTime,this.createdBy,this.productId,this.cateId,this.collectId);

	factory ProductDetail.fromJson(Map<String, dynamic> srcJson) => _$ProductDetailFromJson(srcJson);

	Map<String, dynamic> toJson() => _$ProductDetailToJson(this);

}