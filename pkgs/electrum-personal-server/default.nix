{ stdenv, lib, fetchFromGitHub, python3, python3Packages }:

python3Packages.buildPythonApplication rec {
  pname = "electrum-personal-server";
  version = "0.2.2";
  doCheck = false;

  src = fetchFromGitHub {
    owner = "chris-belcher";
    repo = "electrum-personal-server";
    rev = "eps-v${version}";
    sha256 = "057m1wcwvsvj4qiaysczag2qjrw7wb7532r129y19gpjbw4i6y6b";
  };

  propagatedBuildInputs = with python3Packages; [ wheel pytestrunner setuptools ];

  meta = with lib; {
    description = "An lightweight, single-user implementation of the Electrum server protocol";
    longDescription = ''
      Electrum Personal Server aims to make using Electrum bitcoin wallet 
      more secure and more private. It makes it easy to connect your 
      Electrum wallet to your own full node.
    '';
    homepage = "https://github.com/chris-belcher/electrum-personal-server";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ emmanuelrosa ];
  };
}
