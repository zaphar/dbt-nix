{pkgs}:
with pkgs;
with python39Packages;
let inputs = [
        #attrs
        #Babel
        #boto3
        #agate
        #certifi
        #cffi
        #click
        #colorama
        #hologram
        #idna
        #importlib-metadata
        #isodate
        #jinja2
        #leather
        #Logbook
        #markupsafe
        #msgpack
        #networkx
        #packaging
        #parsedatetime
        #psycopg2
        #pycparser
        #pyparsing
        #pyrsistent
        #python-dateutil
        #python-slugify
        #pytimeparse
        #pytz
        #pyyaml
        #requests
        #sqlparse
        #text-unidecode
        #typing-extensions
        #urllib3
        #werkzeug
        #zipp
        #pyopenssl
        #vcversioner
        #six
        #snowflake-connector-python
        #charset-normalizer
        #dbt-postgres
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
