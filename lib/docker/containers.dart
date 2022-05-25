import 'dart:convert';
import 'dart:io';

void main() async {
  final started = await startContainer();
  print('container started: $started ${started ? '😎' : '😥'}');
}

Future<bool> startContainer({String name = 'pg-test'}) async {
  final p = await Process.start(
    'sh',
    ['docker_run.sh', name],
    workingDirectory: './bin',
    //mode: ProcessStartMode.detachedWithStdio,
  );

  print('docker process pid: ${p.pid}');

  p.stdout.any((e) {
    final output = utf8.decode(e);
    stdout.write(output);
    if (output.contains('database system is ready to accept connections')) {
      return false;
    }
    return false;
  });
  final r = p.stderr.any((e) {
    final output = utf8.decode(e);
    stderr.write(output);
    if (output.contains('database system is ready to accept connections')) {
      return true;
    }
    return false;
  });
  //p.stdout.any((_) => true);
  return r;
}
