import 'package:etajer_flutter/docker/containers.dart';

void main() async {
  final started = await startPgContainer(keepLogging: true);
  print('container started: $started ${started ? '😎' : '😥'}');
}
