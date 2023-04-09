#!/bin/bash
timeout 5s docker stats --no-stream > dockestats.txt
cat dockerstats.txt
