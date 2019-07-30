#!/bin/sh

echo "prepare" && \
rm -rf web/lib/app && \
cp -r ./lib web/lib/app && \
echo "replace" && \
find web/lib/app/*.dart | xargs sed -i "" -e "s/dart:ui/package:flutter_web_ui\/ui.dart/g" && \
find web/lib/app/*.dart | xargs sed -i "" -e "s/flutter\/material/flutter_web\/material/g" && \
echo "build" && \
cd web && \
webdev build && \
echo "docs" && \
cd .. && \
rm -rf docs
cp -r web/build docs
