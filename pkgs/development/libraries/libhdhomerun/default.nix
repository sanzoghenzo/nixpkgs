{ lib, stdenv, fetchurl }:

# libhdhomerun requires UDP port 65001 to be open in order to detect and communicate with tuners.
# If your firewall is enabled, make sure to have something like:
#   networking.firewall.allowedUDPPorts = [ 65001 ];

stdenv.mkDerivation rec {
  pname = "libhdhomerun";
  version = "20220303";

  src = fetchurl {
    url = "https://download.silicondust.com/hdhomerun/libhdhomerun_${version}.tgz";
    sha256 = "sha256-HlT/78LUiTkRUB2jHmYrnQY+bBiv4stcZlMyUnelSpc=";
  };

  postPatch = lib.optionalString stdenv.isDarwin ''
    substituteInPlace Makefile \
      --replace "-arch x86_64" "-arch ${stdenv.hostPlatform.darwinArch}"
  '';

  makeFlags = [
    "CC=${stdenv.cc.targetPrefix}cc"
  ];

  installPhase = ''
    mkdir -p $out/{bin,lib,include/hdhomerun}
    install -Dm444 libhdhomerun${stdenv.hostPlatform.extensions.sharedLibrary} $out/lib
    install -Dm555 hdhomerun_config $out/bin
    cp *.h $out/include/hdhomerun
  '';

  meta = with lib; {
    description = "Implements the libhdhomerun protocol for use with Silicondust HDHomeRun TV tuners";
    homepage = "https://www.silicondust.com/support/linux";
    license = licenses.lgpl21Only;
    platforms = platforms.unix;
    maintainers = [ maintainers.titanous ];
  };
}
