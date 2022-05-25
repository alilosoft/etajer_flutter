import 'dart:convert';
import 'dart:io';

void main() async {
  final started = await startContainer();
  print('container started: $started ${started ? '😎' : '😥'}');
}

Future<bool> startContainer() async {
  final p = await Process.start(
    'bash',
    ['docker_run.sh'],
    workingDirectory: './bin',
  );
  print('docker process pid: ${p.pid}');

  final r = p.stderr.any((e) {
    final output = utf8.decode(e);
    stdout.writeln(output);
    if (output.contains('database system is ready to accept connections')) {
      return true;
    }
    return false;
  });
  return r;
}
