import 'dart:convert';
import 'dart:io';

void main(List<String> args) {
  final dir = Directory(args.isEmpty ? 'lib/l10n' : args.first);
  exitCode = checkArb(dir, stdout.writeln) ? 0 : 1;
}

bool checkArb(Directory dir, void Function(String line) log) {
  if (!dir.existsSync()) {
    log('РЅРµС‚ РїР°РїРєРё СЃ ARB: ${dir.path}');
    return false;
  }
  final templateName = _templateName(dir);
  final template = File('${dir.path}/$templateName');
  if (!template.existsSync()) {
    log('РЅРµС‚ С€Р°Р±Р»РѕРЅРЅРѕР№ Р»РѕРєР°Р»Рё: ${template.path}');
    return false;
  }
  final base = _messages(template);
  final baseLocale = _locale(templateName);

  final others =
      dir
          .listSync()
          .whereType<File>()
          .where(
            (f) => f.path.endsWith('.arb') && !f.path.endsWith(templateName),
          )
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));
  if (others.isEmpty) {
    log(
      'РЅРµС‚ РЅРё РѕРґРЅРѕР№ РІС‚РѕСЂРѕР№ Р»РѕРєР°Р»Рё вЂ” РЅРµС‡РµРіРѕ СЃРІРµСЂСЏС‚СЊ',
    );
    return false;
  }

  var ok = true;
  for (final file in others) {
    final locale = _locale(file.uri.pathSegments.last);
    final other = _messages(file);
    final problems = <String>[
      for (final key in base.keys.where((k) => !other.containsKey(k)))
        '  РЅРµС‚ РІ $locale: $key',
      for (final key in other.keys.where((k) => !base.containsKey(k)))
        '  РЅРµС‚ РІ $baseLocale: $key',
      for (final key in base.keys.where(other.containsKey))
        if (!_sameSet(base[key]!, other[key]!))
          '  $key: РїР»РµР№СЃС…РѕР»РґРµСЂС‹ {${base[key]!.join(', ')}} РІ $baseLocale, '
              '{${other[key]!.join(', ')}} РІ $locale',
    ];
    if (problems.isEmpty) {
      log('$locale: 0 СЂР°СЃС…РѕР¶РґРµРЅРёР№, РєР»СЋС‡РµР№ ${other.length}');
    } else {
      ok = false;
      log('$locale: СЂР°СЃС…РѕР¶РґРµРЅРёР№ ${problems.length}');
      problems.forEach(log);
    }
  }
  return ok;
}

String _templateName(Directory dir) {
  final yaml = File('${dir.parent.parent.path}/l10n.yaml');
  if (yaml.existsSync()) {
    final match = RegExp(
      r'^template-arb-file:\s*(\S+)',
      multiLine: true,
    ).firstMatch(yaml.readAsStringSync());
    if (match != null) return match.group(1)!;
  }
  return 'app_ru.arb';
}

String _locale(String fileName) =>
    fileName.replaceFirst(RegExp(r'^app_'), '').replaceFirst('.arb', '');

Map<String, Set<String>> _messages(File file) {
  final json = jsonDecode(file.readAsStringSync()) as Map<String, Object?>;
  return {
    for (final entry in json.entries)
      if (!entry.key.startsWith('@'))
        entry.key: _placeholders(entry.value.toString()),
  };
}

Set<String> _placeholders(String message) {
  final names = <String>{};
  var depth = 0;
  for (var i = 0; i < message.length; i++) {
    final char = message[i];
    if (char == '{') {
      if (depth == 0) {
        final match = RegExp(r'\s*(\w+)\s*[,}]').matchAsPrefix(message, i + 1);
        if (match != null) names.add(match.group(1)!);
      }
      depth++;
    } else if (char == '}') {
      depth--;
    }
  }
  return names;
}

bool _sameSet(Set<String> a, Set<String> b) =>
    a.length == b.length && a.containsAll(b);
