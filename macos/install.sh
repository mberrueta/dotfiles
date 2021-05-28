#!/bin/sh

brew install $(cat ./brew/packages.txt | sed 's/\#.*//')
