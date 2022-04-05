{pkgs}:
with pkgs;
with python39Packages;
let inputs = [
        jsonschema
        networkx
        mashumaro
        hologram
        colorama
        packaging
        requests
        agate
        minimal-snowplow-tracker
        click
        werkzeug
        jinja2
        logbook
        dbt-extractor
        typing-extensions
        sqlparse
        python-dateutil
        msgpack
        pyyaml
    ];
in
buildPythonPackage rec {
    pname = "dbt-core";
    version = "1.0.0";

    buildInputs = inputs;

    propagatedBuildInputs = inputs;

    doCheck = false;

    src = fetchPypi {
        inherit pname version;
        sha256 = "sha256-kL3gHQeLHWc9xJC53v/wfn87cCuSDGX+rm+yfgfOc9I=";
    };

}
