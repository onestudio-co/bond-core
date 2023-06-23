import 'AndroidLibrary.dart';

abstract class AndroidLibraryInterface {
  Future<List<AndroidLibrary>> listLibraries();

  Future<AndroidLibrary> getLibrary(String name, String version);

  Future<List<AndroidLibrary>> getLibraries(String name);

  Future<void> updateLibrary(AndroidLibrary library);

  Future<void> removeLibrary(AndroidLibrary library);

  Future<void> addLibrary(AndroidLibrary library);
}
