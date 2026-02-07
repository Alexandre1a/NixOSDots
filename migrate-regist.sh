#!/usr/bin/env bash
set -euo pipefail

FILES=$(rg "modules/.+\.nix" -l hosts)

for file in $FILES; do
  echo "Migrating $file"

  # Skip files that already import registry
  if rg "import .*modules" "$file" >/dev/null; then
    continue
  fi

  # Insert let modules = import …
  sed -i '' '
1s|^|let\n  modules = import ../../modules;\nin\n|
' "$file"

  # Replace common patterns
  sed -i '' \
    -e 's|../../modules/common/\([^/]*\)\.nix|modules.common.\1|g' \
    -e 's|../../modules/home-manager/Hyprland/\([^/]*\)\.nix|modules.hm.\1|g' \
    -e 's|../../modules/home-manager/\([^/]*\)\.nix|modules.hm.\1|g' \
    -e 's|../../modules/nixos/\([^/]*\)\.nix|modules.nixos.\1|g' \
    "$file"

done

echo "✓ Migration pass complete"
echo "⚠️  Please review files manually and fix edge cases."
