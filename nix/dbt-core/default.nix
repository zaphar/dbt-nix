{pkgs, version}:
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
        markupsafe
    ];
in
buildPythonPackage rec {
    pname = "dbt-core";
    inherit version;

    buildInputs = inputs;

    propagatedBuildInputs = inputs;

    doCheck = false;

    src = fetchPypi {
        inherit pname version;
        sha256 = "sha256-PjPOW+dODU+fKK12tLHeVcs0PUxTw6j5jCRVGIGu3z4=";
    };
}
