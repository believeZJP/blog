// @dart=2.8
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/business/mall/model/base_model.dart';
import 'package:flutter_module/business/mall/model/footer_model.dart';
import 'package:flutter_module/business/mall/model/banner_carousel_model.dart';
import 'package:flutter_module/business/mall/utils/color_utils.dart';
import 'package:flutter_module/core/utils/localizations.dart';
import 'package:flutter_module/common/widgets/cached_network_image_with_null_safe.dart';

class OfficialRuleCard extends StatelessWidget {
  final BaseModel baseModel;

  OfficialRuleCard({this.baseModel});

  @override
  Widget build(BuildContext context) {
    return getCardWidget();
  }

  Widget getCardWidget() {
    final listWidget =
        ['7天无理由', '买贵退差', '退货补运费'].map((item) => _getRuleItem(item)).toList();

    if (baseModel is BannerCarouselModel) {
      BannerCarouselModel model = baseModel as BannerCarouselModel;
      return Container(
        padding: EdgeInsets.only(bottom: 20, left: 8, right: 8, top: 4),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: ColorUtils.convertToColor('#F0F5FF'),
              ),
              width: 345,
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border(right: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.2), width: 0.5))
                    ),
                    padding: EdgeInsets.only(right: 10),
                    child: Text("官方正品", style: TextStyle(color: ColorUtils.convertToColor('#000000'), height: 1.0, fontSize: 10.0)),
                  ),
                  Row(children: listWidget),
                  // Image.asset(
                  //     "assets/images/mall/mall_home_rule_more.png",
                  //     width: 8,
                  //     height: 16,
                  //   ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: CachedNetworkImageWithNullSafe(
                      imageUrl: "https://bj.bcebos.com/v1/fe-static/xiaodu-app/mall_home_rule_more.png",
                      width: 4,
                      height: 8,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ),
            // Container(
            //   child: Text(
            //     "xiaodu_mall_phone_time".localized(),
            //     style: TextStyle(color: Color(0xff73757A), fontSize: 14),
            //   ),
            // ),
          ],
        ),
      );
    }
    return Container();
  }
}

Widget _getRuleItem(name) {
  if (name != null) {
    return Container(
        padding: EdgeInsets.only(bottom: 4, top: 4, left: 13, right: 3),
        child: Row(children: [
          // Image.asset(
          //   "assets/images/mall/mall_home_rule_safe.png",
          //   width: 22,
          //   height: 26,
          // ),
          CachedNetworkImageWithNullSafe(
            imageUrl: "https://bj.bcebos.com/v1/fe-static/xiaodu-app/mall_home_rule_safe.png",
            width: 11,
            height: 13,
            fit: BoxFit.cover,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(
              name,
              style: TextStyle(color: ColorUtils.convertToColor('#333333'), height: 1.0, fontSize: 10.0),
            ),
          )

        ],)
        );
  }
  return Container();
}