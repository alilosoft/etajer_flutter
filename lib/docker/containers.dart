import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future<bool> startPgContainer({
  String name = 'pg-test',
  bool keepLogging = true,
}) async {
  final p = await Process.start(
    'sh',
    ['docker_run_pgsql.sh', name],
    workingDirectory: './bin',
    //mode: ProcessStartMode.detachedWithStdio,
  );

  final initOutStream = Completer<bool>();
  p.stdout.transform(utf8.decoder).any((line) {
    stdout.write(line);
    if (line.contains('PostgreSQL init process complete;')) {
      initOutStream.complete(true);
    }
    return keepLogging ? false : initOutStream.isCompleted;
  });

  final initErrStream = Completer();
  p.stderr.transform(utf8.decoder).any((line) {
    stderr.write(line);
    if (line.contains('ready to accept connections')) {
      initErrStream.complete(true);
    }
    return keepLogging ? false : initErrStream.isCompleted;
  });

  await initOutStream.future;
  await initErrStream.future;

  if (!keepLogging) {
    final killed = Process.killPid(p.pid);
    stdout.writeln('Killing process ${p.pid}...$killed');
    stdout.writeln('The container $name will keep running in background');
  }

  return Future.value(initOutStream.isCompleted && initErrStream.isCompleted);
}

//TODO: #2 use pg_isready to make sure the server started instead of parsing the log. 
//docker exec -it pg-test pg_isready --timeout=5
// output:  /var/run/postgresql:5432 - accepting connections
//          /var/run/postgresql:5432 - no response

//TODO: #3 add stopContainer(String name)

// TODO: #4 make it OOP class Container { start(); stop(); }