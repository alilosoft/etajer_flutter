import 'package:etajer_flutter/docker/containers.dart';

void main() async {
  final started = await startContainer();
  print('container started: $started ${started ? '😎' : '😥'}');
}
