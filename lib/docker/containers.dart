import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future<bool> startContainer({String name = 'pg-test'}) async {
  final p = await Process.start(
    'sh',
    ['docker_run.sh', name],
    workingDirectory: './bin',
    //mode: ProcessStartMode.detachedWithStdio,
  );

  Completer<bool> outStream = Completer();
  Completer<bool> errStream = Completer();

  p.stdout.transform(utf8.decoder).any((line) {
    stdout.write(line);
    if (line.contains('PostgreSQL init process complete;')) {
      outStream.complete(true);
    }
    return outStream.isCompleted;
  });

  p.stderr.transform(utf8.decoder).any((line) {
    stderr.write(line);
    if (line.contains('ready to accept connections')) {
      errStream.complete(true);
    }
    return errStream.isCompleted;
  });

  await outStream.future;
  await errStream.future;

  final killed = Process.killPid(p.pid);
  print('process killed: $killed');

  return Future.value(outStream.isCompleted && errStream.isCompleted);
}
