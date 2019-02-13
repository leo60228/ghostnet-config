#!/bin/sh
cd "$(dirname $0)"
NIXOS_CONFIG="$(pwd)/configuration.nix" nixos-rebuild --build-host localhost --target-host root@ghostnet.leo60228.space "$@"
