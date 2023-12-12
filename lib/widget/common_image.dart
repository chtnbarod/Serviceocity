import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/core/di/api_provider.dart';
import '../../theme/app_colors.dart';
import '../utils/assets.dart';

class CommonImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final double radius;
  final Color? errorBackground;
  final BoxFit? fit;
  final String? assetPlaceholder;
  final bool userBorder;

  const CommonImage({
    Key? key,
    this.imageUrl = "",
    this.width,
    this.height,
    this.radius = 10,
    this.errorBackground,
    this.fit,
    this.assetPlaceholder,
    this.userBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //color: Colors.black12,
        border: userBorder ? Border.all() : null,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CachedNetworkImage(
          imageUrl:  '$imageUrl',
          width: width,
          height: height,
          fit: fit ?? BoxFit.contain,
          placeholder: (context, url) => Stack(
            children: [
              Image.asset(assetPlaceholder??appPlaceholder,
                width: width,
                height: height,
                fit: fit ?? BoxFit.cover,),
              const Center(
                child: SizedBox(
                    width: 15.0,
                    height: 15.0,
                    child: CircularProgressIndicator(strokeWidth: 1.0,color: AppColors.primary,)
                ),),
            ],
          ),
          errorWidget: (_, __, ___) => Image.asset(assetPlaceholder??appPlaceholder,
            width: width,
            height: height,
            fit: fit ?? BoxFit.cover,),
        ),
      ),
    );
  }

  Widget web(){
   return  ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        '${ApiProvider.url}/$imageUrl',
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        loadingBuilder: (context,child,progress){
          return  Stack(
            children: [
              Image.asset(assetPlaceholder??appPlaceholder,
                width: width,
                height: height,
                fit: fit ?? BoxFit.cover,),
              const Center(
                child: SizedBox(
                    width: 15.0,
                    height: 15.0,
                    child: CircularProgressIndicator(strokeWidth: 1.0,color: AppColors.primary,)
                ),),
            ],
          );
        },
        errorBuilder: (context,error,stackTrace){
          return Image.asset(assetPlaceholder??appPlaceholder,
            width: width,
            height: height,
            fit: fit ?? BoxFit.cover,);
        },
      ),
    );
  }
}
