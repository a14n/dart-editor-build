Dart Editor Build
=================
This package allows a simple interaction with Dart Editor in `build.dart`.
You can read [Build.dart and the Dart Editor Build System](http://www.dartlang.org/tools/editor/build.html) to understand available interactions with Dart Editor.

## Usage ##

### When Dart Editor invokes build.dart ###

You can use the `BuildOptions` to parse arguments.

```dart
final opts = BuildOptions.parse(new Options().arguments);
opts.changed; // The list of files that changed and should be rebuilt.
opts.removed; // The list of files that was removed and might affect the build.
opts.clean; // bool
opts.full; // bool
opts.machine; // bool
opts.deploy; // bool
```

### Provide results to Dart Editor ###

You can use `BuildResult` to create the output of `build.dart`.

```dart
final result = new BuildResult();
result.addError('foo.html', 23,'no ID found');
result.addWarning('foo.html', 24,'no ID found', charStart: 123, charEnd: 130);
result.addInfo('foo.html', 25,'no ID found');
result.addMapping('foo.html', 'out/foo.html');
print(result); // to provide information to editor
```

## License ##
Apache 2.0
