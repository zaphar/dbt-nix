{
    inputs = {
        nixpkgs.url = "nixpkgs";
        flake-utils.url = "github:numtide/flake-utils";
        rust-overlay = {
            url = "github:oxalica/rust-overlay";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {self, nixpkgs, rust-overlay, flake-utils, ...}:
    flake-utils.lib.eachDefaultSystem(system:
        let
            dbt-overlay = import ./nix/overlay.nix;
            # TODO(jwall): Is this overlay strictly necessary?
            pkgs = import nixpkgs {inherit system; overlays = [ dbt-overlay rust-overlay.overlay ]; };
            dbt-core = import ./nix/dbt-core/default.nix { inherit pkgs; };
            dbt-postgres = import ./nix/dbt-postgres/default.nix { inherit pkgs dbt-core; };
            dbt-redshift = import ./nix/dbt-redshift/default.nix { inherit pkgs dbt-core dbt-postgres; };
            dbt-sqlite = import ./nix/dbt-sqlite/default.nix { inherit pkgs dbt-core; };
        in
        {
            inherit dbt-core dbt-postgres dbt-redshift dbt-sqlite;

            overlays = [ dbt-overlay rust-overlay ];
            defaultPackage = dbt-core;
            packages = {
                inherit dbt-core dbt-postgres dbt-redshift dbt-sqlite;
            };
            defaultApp = {
                type = "app";
                program = "${dbt-core}/bin/dbt";
            };
            # Okay now nix develop should work.
            devShell = pkgs.mkShell {
                packages = [ dbt-core dbt-redshift dbt-postgres pkgs.python39 pkgs.python39Packages.pip ];
            };
            devShells = {
                full = pkgs.mkShell { packages = [ dbt-core dbt-postgres dbt-redshift dbt-sqlite ]; };
                core = pkgs.mkShell { packages = [ dbt-core ]; };
                postgres = pkgs.mkShell { packages = [dbt-core dbt-postgres ]; };
                redshift = pkgs.mkShell { packages = [dbt-core dbt-redshift ]; };
                sqlite = pkgs.mkShell { packages = [dbt-core dbt-sqlite ]; };
            };
        });
}