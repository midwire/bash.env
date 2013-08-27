#!/bin/bash
THISDIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
find / > "${THISDIR}/elocatedb"
