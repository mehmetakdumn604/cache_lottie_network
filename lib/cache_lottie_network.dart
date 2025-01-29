library cache_lottie_network;

import 'package:cache_lottie_network/mixins/cache_lottie_mixin.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

class CacheLottieNetwork extends StatefulWidget {
  final String? lottieUrl;
  final Widget? onEmptyWidget;
  final String? cacheKey;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Alignment? alignment;
  final bool? animate;
  final bool? repeat;
  final bool? reverse;
  final FilterQuality? filterQuality;
  final RenderCache? renderCache;

  const CacheLottieNetwork({
    super.key,
    required this.lottieUrl,
    this.onEmptyWidget,
    required this.cacheKey,
    this.width,
    this.height,
    this.fit,
    this.alignment,
    this.animate,
    this.repeat,
    this.reverse,
    this.filterQuality,
    this.renderCache,
  });

  @override
  State<CacheLottieNetwork> createState() => _LottieCacheState();
}

class _LottieCacheState extends State<CacheLottieNetwork>
    with CacheLottieMixin {
  @override
  Widget build(BuildContext context) {
    return Lottie(
      composition: composition,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      alignment: widget.alignment,
      animate: widget.animate,
      repeat: widget.repeat,
      reverse: widget.reverse,
      filterQuality: widget.filterQuality,
      renderCache: widget.renderCache,
    );
  }
}
