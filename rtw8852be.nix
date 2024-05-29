{ lib, stdenv, src, fetchFromGitHub, kernel, bc }:
stdenv.mkDerivation rec {
  name = "rtw8852be-module-unstable-github-${kernel.version}";

  inherit src;

  hardeningDisable = [ "pic" ];
  nativeBuildInputs = kernel.moduleBuildDependencies ++ [ bc ];
  buildFlags = [
    "KSRC=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ];

  installPhase = ''
    mkdir -p $out/lib/modules/${kernel.modDirVersion}/kernel/drivers/net/wireless/
    install -p -m 644 8852be.ko $out/lib/modules/${kernel.modDirVersion}/kernel/drivers/net/wireless/
  '';

  meta = with lib; {
    maintainers = [ maintainers.arobyn ];
    license = [ licenses.agpl3 ];
    platforms = [ "i686-linux" "x86_64-linux" ];
    description = "rtw8852be wifi chip drivers";
    homepage = "https://github.com/vrolife/modern_laptop";
  };
}