{pkgs, dbt-core, dbt-postgres}:
with pkgs;
with python39Packages;
let inputs = [
    dbt-core
    boto3
    typing-extensions
    jinja2
    dbt-postgres
    # we needed to override the test phase so
    # we have to include it from the overlay here.
    s3transfer
    #jinja2_3
];
in
buildPythonPackage rec {
    pname = "dbt-redshift";
    version = "1.0.0";
    buildInputs = inputs;
    propagatedBuildInputs = inputs;
    doCheck = false;
    src = fetchPypi {
        inherit pname version;
        sha256 = "sha256-ZBkhKxxUA1jyubMkCPzmvqyTh8QPgQ2Y33gEOV6Sc78=";
    };
}