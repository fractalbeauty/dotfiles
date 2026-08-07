{ lib
, alsa-lib
, autoPatchelfHook
, dpkg
, fetchurl
, fontconfig
, freetype
, jdk
, libgcc
, libGL
, makeWrapper
, stdenv
, wayland
, xorg
}:
stdenv.mkDerivation rec {
  name = "musicopy";
  version = "1.14.1";

  src = fetchurl {
    url = "https://download.musicopy.app/debian/musicopy_${version}_amd64.deb";
    sha256 = "sha256-hbEjtLC3Cc1F48RzKNGYkl73FHc49AUhe5wepPrqLZc=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    dpkg
    makeWrapper
  ];
  buildInputs = [
    alsa-lib
    freetype
    jdk
    libgcc
    libGL
    stdenv.cc.cc.lib
    wayland
    xorg.libX11
    xorg.libXext
    xorg.libXi
    xorg.libXrender
    xorg.libXtst
  ];

  unpackPhase = ''
    runHook preUnpack

    dpkg-deb -x $src ./src

    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    # Flatten /usr/lib
    mkdir -p "$out"
    cp -r ./src/usr/lib "$out"
    cp -r ./src/usr/share "$out"

    # Wrap the binary with required library paths
    mkdir -p "$out/bin"
    makeWrapper "$out/lib/musicopy/bin/musicopy" "$out/bin/musicopy" \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [ libGL fontconfig xorg.libX11 ]}"

    # Fix path in desktop file
    substituteInPlace "$out/share/applications/app.musicopy.desktop" \
      --replace /usr/lib/ "$out/lib/"

    runHook postInstall
  '';
}
