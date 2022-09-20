library cache_lottie_network;

import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:lottie/lottie.dart';

class CacheLottieNetwork extends StatefulWidget {
  final String? lottieUrl;
  final Widget function;
  final String? keys;

  const CacheLottieNetwork(
      {super.key,
      required this.lottieUrl,
      required this.function,
      required this.keys});

  @override
  State<CacheLottieNetwork> createState() => _LottieCacheState();
}

class _LottieCacheState extends State<CacheLottieNetwork> {
  late ConnectivityResult connection;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();

  Dio dio = Dio();
  var storage = const FlutterSecureStorage();
  String? cacheUrl = "";
  LottieComposition? _composition;
  late ConnectivityResult result;

  doFunction() async {
    _loadComposition().then((value) {
      setState(() {});
    });
  }

  //load secureStorage Read
  Future _loadComposition() async {
    var storagedata = await storage.read(
      key: widget.keys!,
      aOptions: const AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );

    //connection
    try {
      connection = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      debugPrint("No Internet Connection : $e");
    }

    _connectionStatus = connection;

    //Connection Success
    if (_connectionStatus == ConnectivityResult.wifi ||
        _connectionStatus == ConnectivityResult.mobile) {
      try {
        var response;
        var assetData = await dio.get(widget.lottieUrl!);
        response = assetData.data;
        var finaldata = jsonEncode(response);

        final List<int> codeUnits = finaldata.codeUnits;
        final Uint8List unit8List = Uint8List.fromList(codeUnits);
        final byteData = ByteData.view(unit8List.buffer);

        var composition = await LottieComposition.fromByteData(byteData);

        _composition = composition;
        await storage.write(key: widget.keys!, value: finaldata);

        return _composition;
      } on DioError catch (e) {
        //Connection success but didnt have response
        if (e.type == DioErrorType.connectTimeout) {
          if (storagedata != null) {
            final List<int> codeUnits = storagedata.codeUnits;
            final Uint8List unit8List = Uint8List.fromList(codeUnits);
            final byteData = ByteData.view(unit8List.buffer);

            var composition = await LottieComposition.fromByteData(byteData);
            _composition = composition;
            return _composition;
          }
          //if storage Data null
          else {
            return widget.function;
          }
        }
      }
    }
    //Didnt connect to internet
    else {
      final List<int> codeUnits = storagedata!.codeUnits;
      final Uint8List unit8List = Uint8List.fromList(codeUnits);
      final byteData = ByteData.view(unit8List.buffer);

      try {
        var composition = await LottieComposition.fromByteData(byteData);
        _composition = composition;

        return _composition;
      } catch (e) {
        debugPrint("Error Cache Json $e");
      }
    }
  }

  //read Secure Storage
  Future readCache() async {
    await storage
        .read(
            aOptions: const AndroidOptions(
              encryptedSharedPreferences: true,
            ),
            key: widget.keys!)
        .then((value) => cacheUrl = value);
  }

  @override
  void initState() {
    // TODO: implement initState
    // _loadComposition();
    doFunction();
    readCache();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie(
      composition: _composition,
    );
  }
}
