#!/bin/bash
set -e

eval "$(micromamba shell hook --shell=posix)"
micromamba activate base

function install_sources() {
    IFS=','
    to_install=()
    for dir in ${DIRACX_CUSTOM_SOURCE_PREFIXES}; do
        for package_name in ${DIRACX_IMAGE_PACKAGES}; do
            if [[ "${package_name}" == "." ]]; then
                wheel_name="diracx"
            else
                wheel_name="diracx_${package_name}"
            fi
            wheels=( $(find "${dir}" -name "${wheel_name}-*.whl") )
            if [[ ${#wheels[@]} -gt 1 ]]; then
                echo "ERROR: Multiple wheels found for ${package_name} in ${dir}"
                exit 1
            elif [[ ${#wheels[@]} -eq 1 ]]; then
                to_install+=("${wheels[0]}")
            elif [[ -d "${dir}-${package_name}" ]] || [[ "${package_name}" == "." ]]; then
                if [[ -n "${DIRACX_CUSTOM_SOURCE_EDITABLE:-}" ]]; then
                    to_install+=("-e")
                fi
                to_install+=("${dir}-${package_name}")
            fi
        done
    done
    if [[ ${#to_install[@]} -gt 0 ]]; then
        pip install --no-deps "${to_install[@]}"
    fi
}

if [[ -n "${DIRACX_CUSTOM_SOURCE_PREFIXES:-}" ]]; then
    install_sources
fi

exec "$@"
