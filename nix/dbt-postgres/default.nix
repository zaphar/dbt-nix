{pkgs, dbt-core, version}:
with pkgs;
with python39Packages;
let inputs = [
    dbt-core
    typing-extensions
    jinja2
    psycopg2_2_8
];
in
buildPythonPackage rec {
    pname = "dbt-postgres";
    inherit version;
    buildInputs = inputs;
    propagatedBuildInputs = inputs;
    doCheck = false;
    # This is gross but I couldn't figure out how to set an environment variable
    # to configure this properly.
    patchPhase = ''
    sed -ibak "s/psycopg2-binary/psycopg2/" setup.py
    '';
    src = fetchPypi {
        inherit pname version;
        sha256 = "sha256-fz1uSdFju5HpUCKuTSBQzPxibrJVMfD+er6zmfp9B2E=";
    };
}
