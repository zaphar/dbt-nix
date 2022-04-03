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
            dbt-overlay = import ./nix/dbt-core/overlay.nix;
            # TODO(jwall): Is this overlay strictly necessary?
            pkgs = import nixpkgs {inherit system; overlays = [ dbt-overlay rust-overlay.overlay ]; };
            dbt-core = import ./nix/dbt-core/default.nix { inherit pkgs; };
        in
        {
            overlays = [ dbt-overlay rust-overlay ];
            defaultPackage = dbt-core;
            packages.dbt-core = dbt-core;
            devShell = pkgs.mkShell {
                buildInputs = [ dbt-core ];
            };
        });
}