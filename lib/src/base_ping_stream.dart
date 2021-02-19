import 'dart:async';
import 'package:flutter_icmp_ping/src/models/ping_data.dart';

abstract class BasePing {
  BasePing(this.host, this.count, this.interval, this.timeout, this.ipv6) {
    controller = StreamController<PingData>(
        onListen: onListen,
        onCancel: onCancel,
        onPause: () => subscription.pause,
        onResume: () => subscription.resume);
  }

  String host;
  int count;
  double interval;
  double timeout;
  bool ipv6;
  StreamController<PingData> controller;
  StreamSubscription<PingData> subscription;

  Stream<PingData> get stream => controller.stream;

  void onListen();

  void onCancel() {
    subscription.cancel();
    subscription = null;
  }

  void addData(PingData data) => controller.add(data);
}
