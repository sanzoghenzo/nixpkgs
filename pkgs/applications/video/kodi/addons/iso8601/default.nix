{ lib, rel, buildKodiAddon, fetchzip, addonUpdateScript }:

buildKodiAddon rec {
  pname = "iso8601";
  namespace = "script.module.iso8601";
  version = "2.0.0";

  src = fetchzip {
    url = "https://mirrors.kodi.tv/addons/${lib.toLower rel}/${namespace}/${namespace}-${version}.zip";
    sha256 = "sha256-C6EpXK9iXn4JJjIvS4vDPAYUAylN3hcdLcpg8XSGt9M=";
  };

  passthru.updateScript = addonUpdateScript {
    attrPath = "kodi.packages.iso8601";
  };

  meta = with lib; {
    homepage = "https://github.com/micktwomey/pyiso8601";
    description = "Simple module to parse ISO 8601 dates";
    license = licenses.mit;
    maintainers = teams.kodi.members;
  };
}
