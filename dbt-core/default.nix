with import (builtins.fetchTarball {
    name = "nixpkgs-21.05-darwin";
    url = "https://github.com/nixos/nixpkgs/archive/06b49ba179e3e5b13364ed16aa9907821abc6988.tar.gz";
    sha256 = "18dij8g8p71a3ymr58bjn9j7bl9d3hkmzfccc0bqk5fi887i4z7z";
}) {
    overlays = [
        # Overlay our packages to the correct versions.
        # TODO my naming here is wrong and therefore confusing
        (self: super: {
            python39 = super.python39.override {
                packageOverrides =  (pyself: pysuper: {
                    sqlparse = pysuper.sqlparse.overrideAttrs (oldAttrs: rec {
                        version = "0.2.3";
                        pname = oldAttrs.pname;
                        src = pyself.fetchPypi {
                            inherit pname;
                            inherit version;
                            sha256 = "1y7gpqjk15ccgya032214iq2j0r4pprgrvffx0fk3pxvrv3prkdy";
                        };
                    });
                    colorama = pysuper.colorama.overrideAttrs (oldAttrs: rec {
                        version = "0.3.9";
                        pname = oldAttrs.pname;
                        src = pyself.fetchPypi {
                            inherit pname;
                            inherit version;
                            sha256 = "1wd1szk0z3073ghx26ynw43gnc140ibln1safgsis6s6z3s25ss8";
                        };
                    });
                    jsonschema = pysuper.jsonschema.overrideAttrs (oldAttrs: rec {
                        version = "2.6.0";
                        pname = oldAttrs.pname;
                        src = pyself.fetchPypi {
                            inherit pname;
                            inherit version;
                            sha256 = "00kf3zmpp9ya4sydffpifn0j0mzm342a2vzh82p6r0vh10cg7xbg";
                        };
                    });
                    boto3 = pysuper.boto3.overrideAttrs (oldAttrs: rec {
                        version = "1.6.23";
                        pname = oldAttrs.pname;
                        src = pyself.fetchPypi {
                            inherit pname;
                            inherit version;
                            sha256 = "0r28nv8wfrqc0wgacpv939wvw1cqp99wlskwg6nzx3b29d1j6gsj";
                        };
                    });
                    botocore = pysuper.botocore.overrideAttrs (oldAttrs: rec {
                        version = "1.9.23";
                        pname = oldAttrs.pname;
                        src = pyself.fetchPypi {
                            inherit pname;
                            inherit version;
                            sha256 = "147sxvx8gsh2fajxx5rm1r07zvlbhwj42dckkbs5wf3s9j21500m";
                        };
                    });
                    python-dateutil = pysuper.python-dateutil.overrideAttrs (oldAttrs: rec {
                        version = "2.1";
                        pname = oldAttrs.pname;
                        src = pyself.fetchPypi {
                            inherit pname;
                            inherit version;
                            sha256 = "1vlx0lpsxjxz64pz87csx800cwfqznjyr2y7nk3vhmzhkwzyqi2c";
                        };
                        pythonImportsCheck = [ ];
                    });
                    #networkx = pysuper.networkx.overrideAttrs (oldAttrs: rec {
                    #    version = "1.11";
                    #    pname = oldAttrs.pname;
                    #    src = pyself.fetchPypi {
                    #        inherit pname;
                    #        inherit version;
                    #        sha256 = "1f74s56xb4ggixiq0vxyfxsfk8p20c7a099lpcf60izv1php03hd";
                    #    };
                    #});
                    certifi = pyself.buildPythonPackage rec {
                        version = "2020.6.20";
                        pname = "certifi";
                        src = pyself.fetchPypi {
                            inherit pname;
                            inherit version;
                            sha256 = "1lrlxvcaab3kyr5j08dgvw5cvhpij38dldfwp0dx4va92xc5jc2r";
                        };

                        pythonImportsCheck = [ "certifi" ];
                        
                        doCheck = false;

                        meta = with self.lib; {
                          homepage = "https://certifi.io/";
                          description = "Python package for providing Mozilla's CA Bundle";
                          license = licenses.isc;
                        };
                    };
                    snowflake-connector-python = pysuper.snowflake-connector-python.overrideAttrs (oldAttrs: rec {
                        version = "2.4.1";
                        pname = oldAttrs.pname;
                        src = pyself.fetchPypi {
                            inherit pname;
                            inherit version;
                            sha256 = "1bms4z3zjxzzg0m9smgf0h5cm49h8a41c8w3vyqvx9q22bk814aw";
                        };
                    });
                });
            };
        })
    ];
};
with python39Packages;

buildPythonPackage rec {
    pname = "dbt";
    version = "0.12.0";
    
    propagatedBuildInputs = [
        attrs
        Babel
        agate
        certifi
        cffi
        click
        colorama
        hologram
        idna
        importlib-metadata
        isodate
        jinja2
        jsonschema
        leather
        Logbook
        markupsafe
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
        sqlparse
        text-unidecode
        typing-extensions
        urllib3
        werkzeug
        zipp
        snowflake-connector-python
        #charset-normalizer
        #mashumaro
        #minimal-snowplow-tracker
        #dbt-extractor
        #dbt-postgres
    ];
    
    doCheck = false;

    src = fetchPypi {
        inherit pname;
        inherit version;
        #sha256 = "0000000000000000000000000000000000000000000000000000";
        sha256 = "0ymd6pp0vw32s9y3dwcb083ds1cz8y6qiiwcajcyj07ld1wxmc0x";
    };
}
