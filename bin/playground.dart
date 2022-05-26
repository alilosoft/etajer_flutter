import 'package:etajer_flutter/docker/containers.dart';

void main() async {
  final started = await startContainer(keepLogging: true);
  print('container started: $started ${started ? '😎' : '😥'}');
}
