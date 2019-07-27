#!/bin/sh

rm -rf web/lib/app && \
cp -r ./lib web/lib/app && \
find web/lib/app/*.dart | xargs sed -i "" -e "s/dart:ui/package:flutter_web_ui\/ui.dart/g" && \
find web/lib/app/*.dart | xargs sed -i "" -e "s/flutter\/material/flutter_web\/material/g" && \
cd web && \
webdev build && \
cd .. && \
cp -r web/build docs
