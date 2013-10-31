// Copyright (c) 2013, Alexandre Ardhuin
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

library editor_build;

import 'dart:convert' show JSON;

import 'package:args/args.dart';

ArgParser get buildArgParser => new ArgParser()
    ..addOption('changed', allowMultiple: true)
    ..addOption('removed', allowMultiple: true)
    ..addFlag('clean', negatable: false)
    ..addFlag('full', negatable: false)
    ..addFlag('machine', negatable: false)
    ..addFlag('deploy', negatable: false);

class BuildOptions {
  static BuildOptions parse(List<String> args) => new BuildOptions(buildArgParser.parse(args));

  final ArgResults argResults;

  BuildOptions(this.argResults);

  List<String> get changed => argResults['changed'];
  List<String> get removed => argResults['removed'];
  bool get clean => argResults['clean'];
  bool get full => argResults['full'];
  bool get machine => argResults['machine'];
  bool get deploy => argResults['deploy'];
}

class BuildResult {
  final _messages = new List();

  void addError(String file, int line, String message, {int charStart, int charEnd}) => _addProblem("error", file, line, message, charStart: charStart, charEnd: charEnd);
  void addWarning(String file, int line, String message, {int charStart, int charEnd}) => _addProblem("warning", file, line, message, charStart: charStart, charEnd: charEnd);
  void addInfo(String file, int line, String message, {int charStart, int charEnd}) => _addProblem("info", file, line, message, charStart: charStart, charEnd: charEnd);
  void _addProblem(String method, String file, int line, String message, {int charStart, int charEnd}) {
    final param = {
      'file': file,
      'line': line,
      'message': message
    };
    if (charStart != null) param['charStart'] = charStart;
    if (charEnd != null) param['charEnd'] = charEnd;
    _addMessage(method, param);
  }
  void addMapping(String from, String to) {
    _addMessage("mapping", {
      'from': from,
      'to': to
    });
  }
  void _addMessage(String method, Map param) {
    _messages.add({
      "method": method,
      "param": param
    });
  }
  String toString() => JSON.encode(_messages);
}