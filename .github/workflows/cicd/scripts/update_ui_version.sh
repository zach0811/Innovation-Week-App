# !/bin/bash

set -e

tag=$(curl -H "Authorization: Bearer $NEW_TOKEN" https://api.github.com/repos/zach0811/Innovation-Week-Components/releases/latest | jq -r '.tag_name')

NEW_VERSION="${tag#v}"
export NEW_VERSION

echo "$NEW_VERSION"

# NEW_BRANCH="CCUI-0000-Version-Bump-${NEW_VERSION}" >> $GITHUB_ENV
NEW_BRANCH="CCUI-0000-Version-Bump"
echo "New Branch: $NEW_BRANCH"

cd ../.. 
cd ui

echo "Current directory: $(pwd)"

for dir in */; do

    if [ -f "$dir/package.json" ]; then
        echo "Updating $dir/package.json"
        jq --arg newVersion "$NEW_VERSION" '.dependencies["@customer-ui/elements"] = $newVersion' "$dir/package.json" > "$dir/package.json.tmp" && mv "$dir/package.json.tmp" "$dir/package.json"
    fi
done

npm run install:all
npm run build