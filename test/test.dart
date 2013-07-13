import 'package:unittest/unittest.dart';
import 'package:editor_build/editor_build.dart';

main() {
  group('parser', () {
    test('clean', () {
      final opts = BuildOptions.parse(['--clean']);
      expect(opts.changed.length, equals(0));
      expect(opts.removed.length, equals(0));
      expect(opts.clean, isTrue);
      expect(opts.full, isFalse);
      expect(opts.machine, isFalse);
    });
    test('full', () {
      final opts = BuildOptions.parse(['--full']);
      expect(opts.changed.length, equals(0));
      expect(opts.removed.length, equals(0));
      expect(opts.clean, isFalse);
      expect(opts.full, isTrue);
      expect(opts.machine, isFalse);
    });
    test('machine', () {
      final opts = BuildOptions.parse(['--machine']);
      expect(opts.changed.length, equals(0));
      expect(opts.removed.length, equals(0));
      expect(opts.clean, isFalse);
      expect(opts.full, isFalse);
      expect(opts.machine, isTrue);
    });
    test('changed', () {
      final opts = BuildOptions.parse(['--changed', 'a', '--changed', 'b']);
      expect(opts.changed.length, equals(2));
      expect(opts.changed[0], equals('a'));
      expect(opts.changed[1], equals('b'));
      expect(opts.removed.length, equals(0));
      expect(opts.clean, isFalse);
      expect(opts.full, isFalse);
      expect(opts.machine, isFalse);
    });
    test('removed', () {
      final opts = BuildOptions.parse(['--removed', 'a', '--removed', 'b']);
      expect(opts.changed.length, equals(0));
      expect(opts.removed.length, equals(2));
      expect(opts.removed[0], equals('a'));
      expect(opts.removed[1], equals('b'));
      expect(opts.clean, isFalse);
      expect(opts.full, isFalse);
      expect(opts.machine, isFalse);
    });
  });
  group('result', () {
    test('empty', () {
      final result = new BuildResult();
      expect(result.toString(), equals('[]'));
    });
    test('error', () {
      final result = new BuildResult();
      result.addError('foo.html', 23,'no ID found');
      expect(result.toString(), equals('[{"method":"error","param":{"file":"foo.html","line":23,"message":"no ID found"}}]'));
    });
    test('warning', () {
      final result = new BuildResult();
      result.addWarning('foo.html', 24,'no ID found', charStart: 123, charEnd: 130);
      expect(result.toString(), equals('[{"method":"warning","param":{"file":"foo.html","line":24,"message":"no ID found","charStart":123,"charEnd":130}}]'));
    });
    test('info', () {
      final result = new BuildResult();
      result.addInfo('foo.html', 25,'no ID found');
      expect(result.toString(), equals('[{"method":"info","param":{"file":"foo.html","line":25,"message":"no ID found"}}]'));
    });
    test('mapping', () {
      final result = new BuildResult();
      result.addMapping('foo.html', 'out/foo.html');
      expect(result.toString(), equals('[{"method":"mapping","param":{"from":"foo.html","to":"out/foo.html"}}]'));
    });
  });
}