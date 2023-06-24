class AndroidPlugin {
  String name;
  String version;

  AndroidPlugin(this.name, this.version);

  String apply(){
    return "apply plugin: '$name'";
  }
}
