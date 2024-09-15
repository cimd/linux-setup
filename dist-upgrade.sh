#!/bin/bash

echo "Upgrading Ubuntu version"
sudo apt update && sudo apt full-upgrade && sudo do-release-upgrade
