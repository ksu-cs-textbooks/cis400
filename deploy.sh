#!/bin/bash

#git pull --recurse-submodules
hugo
rsync -az public/ nhbean@cslinux.cs.ksu.edu:public_html/cis400
exit 0
