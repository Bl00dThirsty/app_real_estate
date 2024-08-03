import 'dart:async';

import 'package:app_real_estate/utils/helpers/loaders.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';


class NetworkManager extends GetxController {
  static NetworkManager get instance =>Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  /// Initialize the network manager and set up a stream to continually check the connexion status
  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus as void Function(List<ConnectivityResult>)?) as StreamSubscription<ConnectivityResult>;
  }
  ///   Update the connection status based on changes in connectivity and show a revelant popup for no internet
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus.value = result;
    if (_connectionStatus.value == ConnectivityResult.none) {
      /// TODO: Create a loader if it's necessary
      TLoaders.warningSnackBar(title: 'pas de connexion internet');
    }
  }

  /// Check the internet connection status
  /// Returns 'true' if connected, 'false' otherwise

  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.none){
        return false;
      }else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }
}