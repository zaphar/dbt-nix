(self: super: {
            python39 = super.python39.override {
                packageOverrides =  (pyself: pysuper: rec {
                    dbt-extractor = pyself.buildPythonPackage rec {
                        pname = "dbt_extractor";
                        version = "0.4.0";
                        format = "pyproject";
                        nativeBuildInputs = with self.rustPlatform; [
                            cargoSetupHook maturinBuildHook
                        ];
                        # some platforms (MacOS) require this
                        buildInputs = [ self.libiconv ];
                        src = pyself.fetchPypi {
                            inherit pname version;
                            sha256 = "sha256-WGcuNvq5iMhJppNAWSDuGEIfJyRcSOX57PSWNp7TGoU=";
                        };
                        cargoDeps = self.rustPlatform.fetchCargoTarball {
                          inherit src;
                          name = "${pname}-${version}";
                          hash = "sha256-FXMIatCTZJSLaABYO/lcBsONXw8FPNQmcm/tRwkSE54=";
                          patchPhase = ''
                          pwd
                          ls
                          # You can't use the unauthenticated git url format anymore
                          sed -i.bak '/tree-sitter-jinja2/ { s/git:/https:/ }' Cargo.toml
                          '';
                        };
                    };
                    hologram = pyself.buildPythonPackage rec {
                        pname = "hologram";
                        version = "0.0.14";
                        buildInputs = with pyself; [
                            jsonschema
                            python-dateutil
                            colorama
                        ];
                        src = pyself.fetchPypi {
                            inherit pname version;
                            sha256 = "sha256-/We9Bp5GgeHSpEffl2xlBg16kP7n9rhNEz/ZlY2wdOw=";
                        };
                        # The tests use the network so disable for now.
                        doCheck = false;
                    };
                    colorama = pysuper.colorama.overrideAttrs (oldAttrs: rec {
                        version = "0.3.9";
                        pname = oldAttrs.pname;
                        src = pyself.fetchPypi {
                            inherit pname;
                            inherit version;
                            sha256 = "1wd1szk0z3073ghx26ynw43gnc140ibln1safgsis6s6z3s25ss8";
                        };
                    });
                    networkx = pyself.buildPythonPackage rec {
                        pname = "networkx";
                        version = "2.7.1";
                        src = pyself.fetchPypi {
                            inherit pname version;
                            sha256 = "sha256-0RlLp1Pl7tB83s0dI8XNejx3IJm9jb0v6jZniM9N57o=";
                        };
                        # The tests use the network so disable for now.
                        doCheck = false;
                    };
                    pyyaml = with pyself; buildPythonPackage rec {
                        pname = "PyYAML";
                        version = "3.13";
                        src = fetchPypi {
                            inherit pname version;
                            sha256 = "sha256-PvMJIUXptw493Sx61ZvdAlKpTf45SXIWM+QTRN4Apr8=";
                        };
                    };
                    mashumaro = pyself.buildPythonPackage rec {
                        pname = "mashumaro";
                        version = "2.9";
                        buildInputs = [
                            msgpack
                            typing-extensions
                            pyyaml
                            networkx
                        ];
                        src = pyself.fetchPypi {
                            inherit pname version;
                            sha256 = "sha256-NDtuLT5DLjGXNojEyIIdzW70H9MyZLmSr8Suy/0VXxg=";
                        };
                    };
                    jsonschema = pyself.buildPythonPackage rec {
                        pname = "jsonschema";
                        version = "3.0.0";
                        
                        src = pyself.fetchPypi {
                          inherit pname version;
                            sha256 = "sha256-rMipDDHREGBRbP0LQUufi89LxpGyHw94bqV91SVceds=";
                        };

                        nativeBuildInputs = with pyself; [ setuptools-scm ];
                        propagatedBuildInputs = with pyself; [ setuptools attrs importlib-metadata functools32 pyrsistent ];
                        checkInputs = with pyself; [ nose mock pyperf twisted vcversioner ];

                        # zope namespace collides on py27
                        doCheck = false;
                        checkPhase = ''
                          nosetests
                        '';
                    };
                    minimal-snowplow-tracker = with pyself; buildPythonPackage rec {
                        pname = "minimal-snowplow-tracker";
                        version = "0.0.2";
                        buildInputs = [ six requests ];
                        src = fetchPypi {
                            inherit pname version;
                            sha256 = "sha256-rKv3Vy2w5/XL9pg9SV7vVAgfcb45IzDrOq25zLOdqqQ=";
                        };
                    };
                    jinja2 = pysuper.jinja2.overrideAttrs (oldAttrs: rec {
                        version = "2.11.3";
                        pname = oldAttrs.pname;
                        src = pyself.fetchPypi {
                            inherit pname version;
                            sha256 = "sha256-ptWEM94K6AA0fKsfowQ867q+i6qdKeZo8cdoy4ejM8Y=";
                        };
                    });
                    psycopg2 = pysuper.psycopg2.overrideAttrs (oldAttrs: rec {
                        pname = "psycopg2";
                        version = "2.8";
                        src = pyself.fetchPypi {
                            inherit pname version;
                            sha256 = "sha256-ScWDjZDoMheQnbN4nTChBThbXmluxRaM2mRVRsVC81o=";
                        };
                    });
                    #jinja2_3 = pysuper.jinja2.overrideAttrs (oldAttrs: rec {
                    #    version = "3.0.0";
                    #    pname = oldAttrs.pname;
                    #    src = pyself.fetchPypi {
                    #        inherit pname version;
                    #        sha256 = "sha256-6o192BTOnfbeanYex/HKyYr+MFuM3Eqq5OEUuNjOJMU=";
                    #    };
                    #});
                    logbook = with pyself; buildPythonPackage rec {
                        pname = "Logbook";
                        version = "1.5.3";
                        src = fetchPypi {
                            inherit pname version;
                            sha256 = "sha256-ZvRUraD1bq5DBm9gSiIrCYk/mMGtwY3xaXEHYbjzL+g=";
                        };
                        # The tests use the network so disable for now.
                        doCheck = false;
                    };
                    typing-extensions = with pyself; buildPythonPackage rec {
                        pname = "typing_extensions";
                        version = "3.10.0.2";
                        src = fetchPypi {
                            inherit pname version;
                            sha256 = "sha256-SfddFv8R8c0ljhuYjM/4KjylVwIX162MX0ggXdmaZ34=";
                        };
                    };
                    python-dateutil = pysuper.python-dateutil.overrideAttrs (oldAttrs: rec {
                        pname = oldAttrs.pname;
                        version = "2.8.0";
                        src = pyself.fetchPypi {
                            inherit pname version;
                            sha256 = "sha256-yJgF9vTWTbIe2Wb9oTj4pe16T9vBqO4ynOG3Tjx02p4=";
                        };
                    });
                    msgpack = pysuper.msgpack.overrideAttrs (oldAttrs: rec {
                        pname = oldAttrs.pname;
                        version = "0.5.6";
                        src = pyself.fetchPypi {
                            inherit pname version;
                            sha256 = "sha256-DujIyFqmUb46oM0AW1kxdp6qZYyUjOeUKHZvG9Rq4sM=";
                        };
                        doCheck = false;
                        installCheckPhase = "";
                    });
                    #certifi = pyself.buildPythonPackage rec {
                    #    version = "2020.6.20";
                    #    pname = "certifi";
                    #    src = pyself.fetchPypi {
                    #        inherit pname;
                    #        inherit version;
                    #        sha256 = "1lrlxvcaab3kyr5j08dgvw5cvhpij38dldfwp0dx4va92xc5jc2r";
                    #    };

                    #    pythonImportsCheck = [ "certifi" ];
                    #    
                    #    doCheck = false;

                    #    meta = with self.lib; {
                    #      homepage = "https://certifi.io/";
                    #      description = "Python package for providing Mozilla's CA Bundle";
                    #      license = licenses.isc;
                    #    };
                    #};
                });
            };
        })
