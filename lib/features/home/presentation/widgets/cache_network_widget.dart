import 'package:Nexus/core/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CacheNetworkWidget extends StatelessWidget {
  const CacheNetworkWidget({
    super.key,
    required this.height,
    this.isNotCircle = true,
    this.borderRadius,
    required this.imgUrl,
    this.width,
    this.child,
    this.color,
    this.opacity = 1.0,
    this.gradient,
    this.decoration,
  });
  final String imgUrl;
  final double height;
  final double? width;
  final double opacity;
  final bool? isNotCircle;
  final BorderRadiusGeometry? borderRadius;
  final Widget? child;
  final Color? color;
  final Gradient ? gradient;
  final Decoration ? decoration;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: UniqueKey(),
      imageUrl: imgUrl,
      height: height,
      width: width,
      imageBuilder: (context, imageProvider) {
        return Container(
          height: height,
          width: width,
          clipBehavior: Clip.antiAlias,
          decoration:
          decoration ??
           BoxDecoration(
            shape: isNotCircle == true ? BoxShape.rectangle : BoxShape.circle,
            borderRadius: borderRadius,
            color: color,
            gradient: gradient,
            image: DecorationImage(
              image: CachedNetworkImageProvider(imgUrl),
              fit: BoxFit.cover,
              opacity: opacity,
            ),
          ),
          child: child,
        );
      },
      progressIndicatorBuilder: (context, url, progress) {
        return Center(
          child: CircularProgressIndicator(
            value: progress.progress,
            color: primary,
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
          ),
        );
      },
    );
  }
}
