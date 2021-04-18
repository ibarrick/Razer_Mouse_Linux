# This imports the nix package collection,
# so we can access the `pkgs` and `stdenv` variables
with import <nixpkgs> {};

# Make a new "derivation" that represents our shell
stdenv.mkDerivation {
  name = "naga-keybindings";

  src = ./src/naga.cpp;

  buildInputs = [gcc];

  buildPhase = ''
	g++ -pthread -Ofast --std=c++2a src/naga.cpp -o naga
  '';

  installPhase = ''
	echo 'KERNEL=="event[0-9]*",SUBSYSTEM=="input",GROUP="razer",MODE="640"' > $out/lib/udev/rules.d/80-naga.rules
	mv naga $out/bin/
	chmod +x $out/bin/naga
  '';
}
