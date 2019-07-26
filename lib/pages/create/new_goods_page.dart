import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:it_resource_exchange_app/common/constant.dart'
    show AppSize, AppColors;
import 'package:it_resource_exchange_app/model/base_result.dart';
import 'package:it_resource_exchange_app/model/product_detail.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'new_goods_text_field.dart';
import 'new_goods_preview_widget.dart';
import 'package:it_resource_exchange_app/net/network_utils.dart';
import 'package:it_resource_exchange_app/model/cate_info.dart';
import 'package:it_resource_exchange_app/widgets/custom_alert_dialog.dart';
import 'package:oktoast/oktoast.dart';
import 'package:it_resource_exchange_app/widgets/loadingDialog.dart';
import 'package:it_resource_exchange_app/utils/user_utils.dart';
import 'package:it_resource_exchange_app/vo/new_product_vo.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NewGoodsPage extends StatefulWidget {
  NewGoodsPage({Key key, this.productId, this.completeCallback})
      : super(key: key);

  int productId;
  VoidCallback completeCallback;

  @override
  _NewGoodsPageState createState() => _NewGoodsPageState();
}

class _NewGoodsPageState extends State<NewGoodsPage> {
  NewProductVo productVo = NewProductVo.init(cateId: null);

  List<CateInfo> cateList;
  List<DropdownMenuItem> menuItemList = [];

  Function _callBackFunction;


  bool _showLoading = true;

  final _loadingContainer = Container(
      color: Colors.white,
      constraints: BoxConstraints.expand(),
      child: Center(
        child: Opacity(
          opacity: 0.9,
          child: SpinKitRing(
            color: AppColors.PrimaryColor,
            size: 50.0,
          ),
        ),
      ));

  @override
  void initState() {
    super.initState();
    if (this.widget.productId == null) {
      requsetCateListData();
    } else {
      requestGoodsDetailData();
    }
  }

  requestGoodsDetailData() async {
    Future.wait([
      NetworkUtils.requestCategoryListData(),
      NetworkUtils.requestProductDetailByProductId(this.widget.productId)
    ]).then(((res) {
      BaseResult cateListRes = res[0];
      BaseResult productDetailRes = res[1];

      if (cateListRes.status == 200 &&
          productDetailRes.status == 200 &&
          this.mounted) {
        ProductDetail product = ProductDetail.fromJson(productDetailRes.data);
        this.productVo = NewProductVo.init(
            productId: product.productId.toString(),
            title: product.productTitle,
            price: product.price.toString(),
            resourceUrl: product.productAddressUrl,
            resourcePassword: product.productAddressPassword,
            desc: product.productDesc,
            imgUrlList: product.imgUrls.split(','),
            cateId: product.cateId);

        cateList = (cateListRes.data as List)
            .map((m) => CateInfo.fromJson(m))
            .toList();
        menuItemList = cateList.map((cateInfo) {
          return DropdownMenuItem(
              value: cateInfo, child: Text(cateInfo.cateTitle));
        }).toList();

        if (null != this.productVo.cateInfo) {
          for (CateInfo item in cateList) {
            if (item.cateId == this.productVo.cateInfo.cateId) {
              this.productVo.cateInfo = item;
              break;
            }
          }
        }

        setState(() {
          this._showLoading = false;
        });
      }
    }));
  }

  requsetCateListData() {
    NetworkUtils.requestCategoryListData().then((res) {
      if (res.status == 200 && this.mounted) {
        cateList = (res.data as List).map((m) => CateInfo.fromJson(m)).toList();
        menuItemList = cateList.map((cateInfo) {
            return DropdownMenuItem(
                value: cateInfo, child: Text(cateInfo.cateTitle));
          }).toList();

        setState(() {
         this._showLoading = false;
        });
      }
    });
  }

  Widget _buildTitleField() {
    return NewGoodsTextField(
      controller: TextEditingController(text: this.productVo.title),
      hintText: "请输入标题",
      onChanged: (string) {
        this.productVo.title = string;
      },
    );
  }

  Widget _buildPriceField() {
    return NewGoodsTextField(
      controller: TextEditingController(text: this.productVo.price),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(5),
      ],
      hintText: "请输入价格",
      onChanged: (string) {
        this.productVo.price = string;
      },
    );
  }

  Widget _buildResourceUrlField() {
    return NewGoodsTextField(
      controller: TextEditingController(text: this.productVo.resourceUrl),
      keyboardType: TextInputType.url,
      hintText: "请输入资源地址",
      onChanged: (string) {
        this.productVo.resourceUrl = string;
      },
    );
  }

  Widget _buildResourcePasswordField() {
    return NewGoodsTextField(
      controller: TextEditingController(text: this.productVo.resourcePassword),
      hintText: "请输入资源密码",
      onChanged: (string) {
        this.productVo.resourcePassword = string;
      },
    );
  }

  Widget _buildDescField() {
    return TextField(
      controller: TextEditingController(text: this.productVo.desc),
      decoration: InputDecoration(
        hintText: '请输入产品描述',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: AppColors.DividerColor,
            width: AppSize.DividerWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: AppColors.PrimaryColor,
          width: AppSize.DividerWidth,
        )),
      ),
      maxLines: 6,
      onChanged: (string) {
        this.productVo.desc = string;
      },
    );
  }

  Widget _buildChooseCategoryView() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: AppSize.DividerWidth,
            color: AppColors.DividerColor,
          ),
        ),
      ),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "请选择",
            style: TextStyle(fontSize: 17, color: AppColors.MidTextColor),
          ),
          DropdownButton(
              hint: Text('产品分类'),
              iconSize: 35,
              value: this.productVo.cateInfo,
              items: menuItemList,
              onChanged: (selectedCateInfo) {
                setState(() {
                  this.productVo.cateInfo = selectedCateInfo;
                });
              })
        ],
      ),
    );
  }

  Widget _buildPreviewWidget() {
    return NewGoodsPreviewWidget(
      imgVoList: this.productVo.imgVoList,
      onPressed: () {},
      removePressd: (index) {
        this.productVo.imgVoList.removeAt(index);
        setState(() {});
      },
      addPressd: () {
        this.addPrewImgs();
      },
    );
  }

  void addPrewImgs() async {
    String error;

    try {
      List<Asset> tempList = await MultiImagePicker.pickImages(
          enableCamera: true, maxImages: 6 - this.productVo.imgVoList.length);
      List<NewProductImgVo> tempImgVoList = tempList.map((asset) {
        return NewProductImgVo(asset: asset);
      }).toList();

      this.productVo.imgVoList.addAll(tempImgVoList);
    } on PlatformException catch (e) {
      error = e.message;
      print(error);
    }

    if (!mounted) return;

    setState(() {});
  }

  void checkParamsAction() async {
    if (this.productVo.imgVoList.length < 1) {
      showToast('请添加教程预览图片', duration: Duration(milliseconds: 1500));
      return;
    }

    if (null == this.productVo.cateInfo.cateTitle) {
      showToast('请选择教程分类', duration: Duration(milliseconds: 1500));
      return;
    }

    if (this.productVo.title == null) {
      showToast('请输入标题', duration: Duration(milliseconds: 1500));
      return;
    }

    if (this.productVo.price == null) {
      showToast('请输入价格', duration: Duration(milliseconds: 1500));
      return;
    }

    if (this.productVo.price == null) {
      showToast('请输入资源地址', duration: Duration(milliseconds: 1500));
      return;
    }

    if (this.productVo.desc == null) {
      showToast('请输入资源详情描述', duration: Duration(milliseconds: 1500));
      return;
    }

    this.showLoading();
    this.uploadImgAction();
  }

  showLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return LoadingDialog(
          dismissDialog: _disMissCallBack,
        );
      },
    );
  }

  _disMissCallBack(Function func) {
    _callBackFunction = () {
      func();
    };
  }

  void uploadImgAction() {
    List<String> fileNameList = [];
    for (NewProductImgVo imgVo in this.productVo.imgVoList) {
      if (imgVo.url != null) {
        String fileName = imgVo.url.split("?").first.split('/').last;
        fileNameList.add(fileName);
        if (fileNameList.length == this.productVo.imgVoList.length) {
          this.saveProductAction(fileNameList);
        }
      } else {
        imgVo.asset.requestOriginal(quality: 50).then((ByteData data) {
          return data.buffer.asUint8List();
        }).then((List<int> data) async {
          BaseResult result = await NetworkUtils.onUpload(data);
          if (result.status == 200) {
            var fileName = result.data['fileName'];
            fileNameList.add(fileName);
            if (fileNameList.length == this.productVo.imgVoList.length) {
              this.saveProductAction(fileNameList);
            }
          } else {
            throw Exception(result.message);
          }
        }).catchError((e) {
          _callBackFunction();
          showToast(e.toString(), duration: Duration(milliseconds: 2500));
        });
      }
    }
  }

  void saveProductAction(List<String> fileNameList) {
    var params = {
      'cateId': this.productVo.cateInfo.cateId,
      'imgUrls': fileNameList.join(','),
      'coverUrl': fileNameList.first,
      'price': this.productVo.price,
      'productTitle': this.productVo.title,
      'productDesc': this.productVo.desc,
      'productAddressUrl': this.productVo.resourceUrl,
      'createdBy': UserUtils.getUserInfo().userId
    };

    if (null != this.productVo.productId) {
      params['productId'] = this.productVo.productId;
    }

    if (null != this.productVo.resourcePassword) {
      params['productAddressPassword'] = this.productVo.resourcePassword;
    }

    NetworkUtils.submitProduct(params).then((res) {
      _callBackFunction();
      if (res.status == 200) {
        showToast('发布成功,等待管理员审核', duration: Duration(seconds: 3));
        this.widget.completeCallback();
        Future.delayed(Duration(seconds: 3), () {
          Navigator.of(context).pop();
        });
      } else {
        showToast('发布失败,${res.message}', duration: Duration(seconds: 3));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var body = GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 8),
                _buildChooseCategoryView(),
                _buildTitleField(),
                _buildPriceField(),
                _buildResourceUrlField(),
                _buildResourcePasswordField(),
                SizedBox(height: 10),
                _buildDescField(),
                SizedBox(height: 18),
                Text('提示:默认使用第一张图作为教程的封面'),
                SizedBox(height: 5),
                _buildPreviewWidget(),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      );


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text(
            "发布资源",
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  showDialog<Null>(
                      context: context, //BuildContext对象
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return CustomAlertDialog(
                          desc: '确定要保存此教程吗？',
                          onChanged: (bool onChanged) {
                            if (onChanged) {
                              this.checkParamsAction();
                            }
                          },
                        );
                      });
                }),
          ]),
      body: _showLoading ? _loadingContainer : body
    );
  }
}
