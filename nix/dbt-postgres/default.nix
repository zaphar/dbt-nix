
{pkgs, dbt-core}:
with pkgs;
with python39Packages;
let inputs = [
    dbt-core
    typing-extensions
    jinja2
    psycopg2
];
in
buildPythonPackage rec {
    pname = "dbt-postgres";
    version = "1.0.0";
    buildInputs = inputs;
    propagatedBuildInputs = inputs;
    doCheck = false;
    # This is gross but I couldn't figure out how to set an environment variable
    # to configure this properly.
    patchPhase = ''
    sed -ibak "s/return 'psycopg2-binary'/return 'psycopg2'/" setup.py
    '';
    src = fetchPypi {
        inherit pname version;
        sha256 = "sha256-eOrEulixIEBx3oTbaaxE3Gg3K2gNo5h5QoJhM48SKZI=";
    };
}