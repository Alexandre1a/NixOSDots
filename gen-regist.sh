#!/usr/bin/env bash
set -euo pipefail

REGISTRY="modules/default.nix"

echo "Generating $REGISTRY …"

{
  echo "{"

  echo "  common = {"
  find modules/common -name "*.nix" -maxdepth 1 | sort | while read -r f; do
    name=$(basename "$f" .nix)
    echo "    $name = ./${f#modules/};"
  done
  echo "  };"

  echo ""
  echo "  hm = {"
  find modules/home-manager -name "*.nix" | sort | while read -r f; do
    name=$(basename "$f" .nix)
    echo "    $name = ./${f#modules/};"
  done
  echo "  };"

  echo ""
  echo "  nixos = {"
  find modules/nixos -name "*.nix" | sort | while read -r f; do
    name=$(basename "$f" .nix)
    echo "    $name = ./${f#modules/};"
  done
  echo "  };"

  echo ""
  echo "  macos = {"
  find modules/macos -name "*.nix" | sort | while read -r f; do
    name=$(basename "$f" .nix)
    echo "    $name = ./${f#modules/};"
  done
  echo "  };"

  echo "}"
} > "$REGISTRY"

echo "✓ Registry generated at $REGISTRY"
