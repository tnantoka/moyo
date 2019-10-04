#!/bin/sh

flutter build web
rm -rf docs
mv build/web docs
