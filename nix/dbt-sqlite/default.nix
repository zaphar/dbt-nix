{pkgs, dbt-core, ...}:
with pkgs;
with python39Packages;

buildPythonPackage rec {
    pname = "dbt-sqlite";
    version = "1.0.0";
    propagatedBuildInputs = [
        dbt-core
    ];
    src = fetchPypi {
        inherit pname version;
        sha256 = "sha256-nIwk30kMvWBtbAPVE1kfdc4l9W3rWdBRB082OyoiccA=";
    };
}