#!/usr/bin/env bash

BUILD_PATH=".build/release"

PACKAGE_PATH="${BUILD_PATH}/Package"
HOME_TOOLS="${PACKAGE_PATH}/HomeTools"

rm -rf "${PACKAGE_PATH}"
mkdir "${PACKAGE_PATH}"
mkdir "${HOME_TOOLS}"

cp -r "Resources" "${HOME_TOOLS}"
cp -r "Public" "${HOME_TOOLS}"
cp -r "${BUILD_PATH}/HomeTools" "${HOME_TOOLS}"
cp -r "Libs" "${HOME_TOOLS}/lib"

tar -czvf "HomeTools.tar.gz" -C "${PACKAGE_PATH}" .

echo "---"
echo "Compressed to HomeTools.tar.gz"

