import 'dart:io';

import 'AndroidLibrary.dart';
import 'AndroidLibraryInterface.dart';

class AndroidLibraryManager implements AndroidLibraryInterface {

  File buildFile;

  AndroidLibraryManager(this.buildFile);

  @override
  Future<List<AndroidLibrary>> listLibraries() async {
    throw Exception("not implemented yet");
  }

  @override
  Future<AndroidLibrary> getLibrary(String name, String version) async {
    throw Exception("not implemented yet");
  }

  @override
  Future<List<AndroidLibrary>> getLibraries(String name) async {
    throw Exception("not implemented yet");
  }

  @override
  Future<void> updateLibrary(AndroidLibrary library) async {
    throw Exception("not implemented yet");
  }

  @override
  Future<void> removeLibrary(AndroidLibrary library) async {
    throw Exception("not implemented yet");
  }

  @override
  Future<void> addLibrary(AndroidLibrary library) async {
    throw Exception("not implemented yet");
  }
}
