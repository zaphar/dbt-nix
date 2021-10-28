with import <nixpkgs> {};
with python38Packages;

buildPythonPackage rec {
    pname = "dbt";
    version = "0.12.0";
    
    propagatedBuildInputs = [
        agate
        attrs
        Babel
        certifi
        cffi
        charset-normalizer
        click
        colorama
        #dbt-extractor
        #dbt-postgres
        hologram
        idna
        importlib-metadata
        isodate
        jinja2
        jsonschema
        leather
        Logbook
        markupsafe
        #mashumaro
        #minimal-snowplow-tracker
        msgpack
        networkx
        packaging
        parsedatetime
        #psycopg2-binary
        pycparser
        pyparsing
        pyrsistent
        python-dateutil
        python-slugify
        pytimeparse
        pytz
        pyyaml
        requests
        six
        sqlparse
        text-unidecode
        typing-extensions
        urllib3
        werkzeug
        zipp
        snowflake-connector-python
    ];
    
    doCheck = false;

    src = fetchPypi {
        inherit pname;
        inherit version;
        #sha256 = "0000000000000000000000000000000000000000000000000000";
        sha256 = "0ymd6pp0vw32s9y3dwcb083ds1cz8y6qiiwcajcyj07ld1wxmc0x";
    };
}
