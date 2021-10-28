with import (builtins.fetchTarball {
    name = "nixpkgs-21.05-darwin";
    url = "https://github.com/nixos/nixpkgs/archive/06b49ba179e3e5b13364ed16aa9907821abc6988.tar.gz";
    sha256 = "18dij8g8p71a3ymr58bjn9j7bl9d3hkmzfccc0bqk5fi887i4z7z";
}) {
    overlays = [
        # Overlay our SQLParse to be the correct version.
        (prev: final: {
            sqlparse = prev.sqlparse.overrideAttrPythonAttrs (oldAttrs: rec {
                version = "0.2.3";
                pname = oldAttrs.pname;
                src = prev.fetchPypi {
                    inherit pname;
                    inherit version;
                    sha256 = "0000000000000000000000000000000000000000000000000000";
                };
            });
        })
    ];
};
with python39Packages;

buildPythonPackage rec {
    pname = "dbt";
    version = "0.12.0";
    
    propagatedBuildInputs = [
        agate
        attrs
        Babel
        certifi
        cffi
        #charset-normalizer
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
        psycopg2
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
        # TODO(jwall): We need to override sqlparse here to be exactly version 0.2.3
        sqlparse
        text-unidecode
        typing-extensions
        urllib3
        werkzeug
        zipp
        #snowflake-connector-python
    ];
    
    doCheck = false;

    src = fetchPypi {
        inherit pname;
        inherit version;
        #sha256 = "0000000000000000000000000000000000000000000000000000";
        sha256 = "0ymd6pp0vw32s9y3dwcb083ds1cz8y6qiiwcajcyj07ld1wxmc0x";
    };
}
