{ lib, rel, buildKodiAddon, fetchzip, addonUpdateScript, iso8601, requests, yaml }:

buildKodiAddon rec {
  pname = "homeassistant";
  namespace = "script.program.homeassistant";
  version = "1.2.0";

  src = fetchzip {
    url = "https://mirrors.kodi.tv/addons/${lib.toLower rel}/${namespace}/${namespace}-${version}.zip";
    sha256 = "sha256-fBvATieModKb7WM4r6BW3MSGfBfuz2tP+tZbUgJHLjc=";
  };

  propagatedBuildInputs = [
    iso8601
    requests
    yaml
  ];

  passthru = {
    updateScript = addonUpdateScript {
      attrPath = "kodi.packages.homeassistant";
    };
  };

  meta = with lib; {
    homepage = "https://github.com/LaTrappe/HAKA";
    description = "This is Home Assistant Kodi Addon (HAKA!)";
    license = licenses.gpl3Plus;
    maintainers = teams.kodi.members;
  };
}
