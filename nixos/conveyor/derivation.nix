{
  alsa-lib,
  autoPatchelfHook,
  dpkg,
  fetchurl,
  freetype,
  gcc,
  jdk,
  libgcc,
  stdenv,
  xorg,
}:
stdenv.mkDerivation rec {
  name = "conveyor";
  version = "19.0";

  src = fetchurl {
    url = "https://downloads.hydraulic.dev/conveyor/hydraulic-conveyor_${version}_amd64.deb";
    sha256 = "sha256-VD0fbFghiYbunJFxMr81UXvu8MVfG8UpyKnkvcOim1g=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    dpkg
  ];
  buildInputs = [
    alsa-lib
    freetype
    jdk
    libgcc
    stdenv.cc.cc.lib
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

    # Symlink the binary
    mkdir -p "$out/bin"
    ln -s "$out/lib/hydraulic/conveyor/bin/conveyor" "$out/bin/conveyor"

    # Fix path in desktop file
    substituteInPlace "$out/share/applications/dev.hydraulic.conveyor.desktop" \
      --replace /usr/lib/ "$out/lib/"

    runHook postInstall
  '';
}
