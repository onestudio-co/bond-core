class AndroidLibrary {
  String name;
  String? version;

  AndroidLibrary(this.name, {this.version});

  String toGradle() {
    String versionPart = (version == null || version == '') ? '' : ':$version';
    return '    implementation "$name$versionPart"\n';
  }
}

class BomAndroidLibrary implements AndroidLibrary {
  @override
  String name;

  @override
  String? version;

  BomAndroidLibrary(this.name, this.version);

  @override
  String toGradle() {
    return '    implementation platform("$name:$version")\n';
  }
}
