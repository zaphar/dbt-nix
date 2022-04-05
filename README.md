# A nix flake for working with dbt

## Usage

You can get a development shell with the `nix shell` command.

```sh
nix shell github:zaphar/dbt-nix#dbt-core github:zaphar/dbt-nix#dbt-redshift
dbt --version
```

## Flake outputs

* packages.`${system}`.dbt-core - the dbt-core cli
* packages.`${system}`.dbt-redshift - the dbt-redshift plugin (also includes dbt-postgres)