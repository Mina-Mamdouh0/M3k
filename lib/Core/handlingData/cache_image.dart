
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:m3k/Core/handlingData/loading_app_custom.dart';
import 'package:m3k/Core/unit/assets_data.dart';

class CacheImageCustom extends StatelessWidget {
  BoxFit ? boxFit;
  final String image;
   double? width;
   double? height;
  CacheImageCustom({Key? key, required this.image,  this.width,  this.height,this.boxFit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      width: width,
      height: height,
      fit: boxFit??BoxFit.fill,
      placeholder: (context, url) => const LoadingAppCustom(),
      errorWidget: (context, url, error) {
        return SvgPicture.asset(AssetsData.logoImage,
            width: width,height: height,fit: boxFit??BoxFit.fill);
      },
    );
  }
}
