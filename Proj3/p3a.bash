#!/bin/bash
awk -f p3a.awk unsortedNames.txt | sort | cat > p3a.out | awk -f p3aFix.awk p3a.out > p3a.out
