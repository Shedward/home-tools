#!/usr/bin/env bash

BUILD_PATH=".build/release"

PACKAGE_PATH="${BUILD_PATH}/Package"

rm -rf "${PACKAGE_PATH}"
mkdir "${PACKAGE_PATH}"

cp -r "Resources" "${PACKAGE_PATH}"
cp -r "Public" "${PACKAGE_PATH}"
cp -r "${BUILD_PATH}/HomeTools" "${PACKAGE_PATH}"
cp -r "Libs" "${PACKAGE_PATH}/lib"

tar -czvf "HomeTools.tar.gz" -C "${PACKAGE_PATH}" .

echo "---"
echo "Compressed to HomeTools.tar.gz"

