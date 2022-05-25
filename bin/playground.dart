import 'dart:io';

void main() async {
  final containerID = await startContainer();
  print('the end 😎 $containerID');
}

startContainer() async {
  final p = await Process.start(
    'bash',
    ['docker_run.sh'],
    workingDirectory: './bin',
  );
  print('docker process pid: ${p.pid}');
  stderr.addStream(p.stderr);
  await stdout.addStream(p.stdout);
  return p.pid;
}
