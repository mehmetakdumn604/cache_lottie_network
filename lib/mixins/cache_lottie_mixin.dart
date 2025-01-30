import 'dart:convert';

import 'package:cached_lottie_network/cache_lottie_network.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lottie/lottie.dart';

mixin CacheLottieMixin on State<CachedLottieNetwork> {
  late ConnectivityResult connection;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();

  final Dio dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
  ));

  final FlutterSecureStorage storage = const FlutterSecureStorage();
  String? cacheUrl = "";
  LottieComposition? composition;
  late ConnectivityResult result;

  doFunction() async {
    _loadComposition().then((value) {
      setState(() {});
    });
  }

  //load secureStorage Read
  Future _loadComposition() async {
    try {
      // First check cache

      final cachedData = widget.cacheKey != null
          ? await storage.read(
              key: widget.cacheKey!,
              aOptions: const AndroidOptions(
                encryptedSharedPreferences: true,
              ),
            )
          : null;

      // If we have cached data, use it
      if (cachedData != null) {
        try {
          composition = await _createCompositionFromData(cachedData);

          return composition;
        } catch (e) {
          debugPrint("Error parsing cached data: $e");
          // If cache is corrupted, continue to fetch from network
        }
      }

      // Check internet connection before network request
      try {
        final List<ConnectivityResult> results =
            await _connectivity.checkConnectivity();
        if (results.isEmpty) {
          debugPrint("No connectivity results available");
          return widget.onEmptyWidget;
        }
        connection = results.first;
        _connectionStatus = connection;

        // If we have internet connection
        if (_connectionStatus != ConnectivityResult.none) {
          final response = await dio.get(widget.lottieUrl!);
          final data = jsonEncode(response.data);

          // Create composition from network data
          composition = await _createCompositionFromData(data);

          // Save to cache for future use
          await storage.write(key: widget.cacheKey!, value: data);

          return composition;
        } else {
          debugPrint("No internet connection available");
          return widget.onEmptyWidget;
        }
      } on PlatformException catch (e) {
        debugPrint("Platform error checking connectivity: $e");
        return widget.onEmptyWidget;
      } on DioException catch (e) {
        debugPrint("Network error: $e");
        return widget.onEmptyWidget;
      }
    } catch (e) {
      debugPrint("Unexpected error: $e");
      return widget.onEmptyWidget;
    }
  }

  // Helper method to create LottieComposition from string data
  Future<LottieComposition> _createCompositionFromData(String data) async {
    final List<int> codeUnits = data.codeUnits;
    final Uint8List unit8List = Uint8List.fromList(codeUnits);
    final byteData = ByteData.view(unit8List.buffer);
    return await LottieComposition.fromByteData(byteData);
  }

  //read Secure Storage
  void readCache() {
    storage
        .read(
            aOptions: const AndroidOptions(
              encryptedSharedPreferences: true,
            ),
            key: widget.cacheKey!)
        .then((value) => cacheUrl = value);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      doFunction();
    });
    readCache();
    super.initState();
  }
}
