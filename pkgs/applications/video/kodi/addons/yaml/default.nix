{ lib, rel, buildKodiAddon, fetchzip, addonUpdateScript }:

buildKodiAddon rec {
  pname = "yaml";
  namespace = "script.module.yaml";
  version = "6.0.1";

  src = fetchzip {
    url = "https://mirrors.kodi.tv/addons/${lib.toLower rel}/${namespace}/${namespace}-${version}.zip";
    sha256 = "sha256-lOq1NWH8vVP9vEr5kp5gC2y9wjKO9s9nKUIUmu0cG60=";
  };

  passthru.updateScript = addonUpdateScript {
    attrPath = "kodi.packages.yaml";
  };

  meta = with lib; {
    homepage = "https://github.com/yaml/pyyaml";
    description = "YAML parser and emitter for Python";
    license = licenses.mit;
    maintainers = teams.kodi.members;
  };
}
