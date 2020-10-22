#!/bin/sh
set -euo pipefail

VERSION=${1#"v"}
if [ -z "$VERSION" ]; then
    echo "Must specify version!"
    exit 1
fi
MODS=($(
    #curl -sS https://raw.githubusercontent.com/kubernetes/kubernetes/v${VERSION}/go.mod |
    #sed -n 's|.*k8s.io/\(.*\) => ./staging/src/k8s.io/.*|k8s.io/\1|p'
    sed -n 's|.*k8s.io/\(.*\) => ./staging/src/k8s.io/.*|k8s.io/\1|p' k8s1.18.4-go.mod
))
for MOD in "${MODS[@]}"; do
#    V=$(
#        go mod download -json "${MOD}@kubernetes-${VERSION}" |
#        sed -n 's|.*"Version": "\(.*\)".*|\1|p'
#    )
    go mod edit "-replace=${MOD}=k8s.io/kubernetes/staging/src/${MOD}@v0.0.0-20200617113309-c96aede7b520"
done

echo "start get package..."
#go get "k8s.io/kubernetes@v${VERSION}"