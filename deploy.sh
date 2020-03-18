#!/bin/bash

git pull --recurse-submodules
hugo
scp -r public nhbean@cs.ksu.edu:public_html/cis400
exit 0
