import 'package:etajer_flutter/docker/containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late bool started;
  setUp(() async {
    started = await startContainer();
    debugPrint('container started: $started ${started ? '😎' : '😥'}');
  });

  test('container should be started', () {
    expect(started, true);
  });
}
