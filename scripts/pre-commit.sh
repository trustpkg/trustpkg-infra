#!/bin/bash

source scripts/helpers/runLog.sh "Run pre-commit checks"

which gitleaks 1>/dev/null 2>&1 || {
    source scripts/helpers/warningLog.sh "gitleaks is not installed."
    echo "run below command to install gitleaks: dnf install gitleaks"
    
    exit 1
}

gitleaks detect --verbose --redact --exit-code 1

source scripts/helpers/successLog.sh "Pre-commit checks passed."