{pkgs, dbt-core, ...}:
with pkgs;
with python39Packages;
let
    dbt-sqlite = buildPythonPackage rec {
        pname = "dbt-sqlite";
        version = "1.1.0";
        propagatedBuildInputs = [
            dbt-core
        ];
        src = fetchPypi {
            inherit pname version;
            sha256 = "sha256-Nktr0mQWYQ7FGl1AB/BBHZCu0YZeA/M7oaZMDLE+NtI=";
        };
    };
in symlinkJoin {
    name = "dbt-sqlite-bundled";
    paths = [ dbt-sqlite sqlite ];
}
