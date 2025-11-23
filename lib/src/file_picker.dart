import 'dart:async';
import 'dart:io';

import 'package:file_picker_writable/file_picker_writable.dart';
import 'package:file_picker/file_picker.dart' as fp;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:orgro/src/temp_localizations.dart';
import 'package:orgro/src/data_source.dart';
import 'package:path/path.dart' as path;

// Platform-aware file picker implementation
Future<NativeDataSource?> pickFile() async {
  if (!kIsWeb && Platform.isMacOS) {
    return _pickFileMacOS();
  } else {
    return FilePickerWritable().openFile(LoadedNativeDataSource.fromExternal);
  }
}

Future<NativeDirectoryInfo?> pickDirectory({String? initialDirUri}) async {
  if (!kIsWeb && Platform.isMacOS) {
    return _pickDirectoryMacOS(initialDirUri: initialDirUri);
  } else {
    final dirInfo =
        await FilePickerWritable().openDirectory(initialDirUri: initialDirUri);
    return dirInfo == null
        ? null
        : NativeDirectoryInfo(
            dirInfo.fileName ?? 'unknown',
            dirInfo.identifier,
            dirInfo.uri,
          );
  }
}

Future<NativeDataSource?> readFileWithIdentifier(String identifier) async {
  if (!kIsWeb && Platform.isMacOS) {
    return _readFileWithIdentifierMacOS(identifier);
  } else {
    try {
      return await FilePickerWritable().readFile(
          identifier: identifier, reader: LoadedNativeDataSource.fromExternal);
    } catch (e) {
      debugPrint('Error reading file with identifier: $e');
      return null;
    }
  }
}

Future<bool> canObtainNativeDirectoryPermissions() async {
  if (!kIsWeb && Platform.isMacOS) {
    return true;
  } else {
    return FilePickerWritable().isDirectoryAccessSupported();
  }
}

Future<void> disposeNativeSourceIdentifier(String identifier) {
  if (!kIsWeb && Platform.isMacOS) {
    return Future.value();
  } else {
    return FilePickerWritable().disposeIdentifier(identifier);
  }
}

// macOS-specific implementations using file_picker
Future<NativeDataSource?> _pickFileMacOS() async {
  try {
    final result = await fp.FilePicker.platform.pickFiles(
      type: fp.FileType.custom,
      allowedExtensions: ['org'],
      allowMultiple: false,
      // On macOS, we need directory access to resolve relative links
      lockParentWindow: true,
    );

    if (result == null || result.files.isEmpty) {
      return null;
    }

    final file = result.files.first;
    if (file.path == null) {
      return null;
    }

    final ioFile = File(file.path!);
    final content = await ioFile.readAsString();
    
    // Store the parent directory path for resolving relative links
    final parentDir = ioFile.parent.path;
    debugPrint('Opened file: ${file.path}');
    debugPrint('Parent directory: $parentDir');

    return LoadedNativeDataSource(
      file.name,
      file.path!,
      ioFile.uri.toString(),
      content,
      persistable: true,
    );
  } catch (e) {
    debugPrint('Error picking file on macOS: $e');
    return null;
  }
}

Future<NativeDirectoryInfo?> _pickDirectoryMacOS({String? initialDirUri}) async {
  try {
    final result = await fp.FilePicker.platform.getDirectoryPath(
      initialDirectory: initialDirUri != null
          ? Uri.parse(initialDirUri).toFilePath()
          : null,
    );

    if (result == null) {
      return null;
    }

    return NativeDirectoryInfo(
      path.basename(result),
      result,
      Uri.file(result).toString(),
    );
  } catch (e) {
    debugPrint('Error picking directory on macOS: $e');
    return null;
  }
}

Future<NativeDataSource?> _readFileWithIdentifierMacOS(String identifier) async {
  try {
    // 解析标识符（可能是 URI 或路径）
    String filePath = identifier;
    if (identifier.startsWith('file://')) {
      filePath = Uri.parse(identifier).toFilePath();
    }
    
    final file = File(filePath);
    
    // 检查文件是否存在
    if (!await file.exists()) {
      debugPrint('File does not exist: $filePath');
      return null;
    }
    
    // 读取文件内容
    final content = await file.readAsString();

    return LoadedNativeDataSource(
      path.basename(filePath),
      filePath,
      file.uri.toString(),
      content,
      persistable: true,
    );
  } catch (e) {
    debugPrint('Error reading file with identifier: $e');
    return null;
  }
}

mixin PlatformOpenHandler<T extends StatefulWidget> on State<T> {
  FilePickerState? _filePickerState;

  @override
  void initState() {
    super.initState();
    // Only initialize for mobile platforms (iOS/Android)
    if (!kIsWeb && !Platform.isMacOS) {
      _filePickerState = FilePickerWritable().init()
        ..registerFileOpenHandler(_loadFile)
        ..registerErrorEventHandler(_handleError);
    }
  }

  Future<bool> _loadFile(FileInfo fileInfo, File file) async {
    NativeDataSource openFileInfo;
    try {
      openFileInfo = await LoadedNativeDataSource.fromExternal(fileInfo, file);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      await _displayError(e.toString());
      return false;
    }
    return loadFileFromPlatform(openFileInfo);
  }

  Future<bool> loadFileFromPlatform(NativeDataSource info);

  Future<bool> _handleError(ErrorEvent event) async {
    await _displayError(event.message);
    return true;
  }

  Future<void> _displayError(String message) async => showDialog<void>(
        context: context,
        builder: (context) => SimpleDialog(
          title: Text(AppLocalizations.of(context)!.dialogTitleError),
          children: [ListTile(title: Text(message))],
        ),
      );

  @override
  void dispose() {
    _filePickerState
      ?..removeFileOpenHandler(_loadFile)
      ..removeErrorEventHandler(_handleError);
    super.dispose();
  }
}
