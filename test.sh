#!/bin/bash

set -e

gforth \
    src/world/array.spec.f \
    src/world/hexagonal-mapping.spec.f \
    -e bye

