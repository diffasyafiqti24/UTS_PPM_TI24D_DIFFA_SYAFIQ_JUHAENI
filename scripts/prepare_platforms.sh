#!/usr/bin/env bash
set -euo pipefail

if [[ ! -d android || ! -d ios ]]; then
  flutter create \
    --project-name activity_counter_mvvm \
    --org id.nusaputra \
    --platforms android,ios,web \
    .
fi

flutter pub get
flutter analyze
flutter test

echo "Platform Flutter dan dependency berhasil disiapkan."
