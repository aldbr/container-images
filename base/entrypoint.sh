#!/bin/bash
set -e

eval "$(micromamba shell hook --shell=posix)"
micromamba activate base

function install_sources() {
    IFS=','
    for dir in ${DIRACX_CUSTOM_SOURCE_PREFIXES}; do
        for package_name in ${DIRACX_IMAGE_PACKAGES}; do
            if [[ "${package_name}" == "." ]]; then
                wheel_name="diracx"
            else
                wheel_name="diracx_${package_name}"
            fi
            wheels=("${dir}/${wheel_name}"-*.whl)
            if [[ ${wheels[#]} -gt 1 ]]; then
                echo "ERROR: Multiple wheels found for ${package_name} in ${dir}"
                exit 1
            elif [[ ${wheels[#]} -eq 1 ]]; then
                pip install "${wheels[0]}"
            elif [[ -d "${dir}-${package_name}" ]] || [[ "${package_name}" == "." ]]; then
                if [[ -n "${DIRACX_CUSTOM_SOURCE_EDITABLE:-}" ]]; then
                    pip install -e "${dir}-${package_name}"
                else
                    pip install "${dir}-${package_name}"
                fi
            fi
        done
    done
}

if [[ -n "${DIRACX_CUSTOM_SOURCE_PREFIXES:-}" ]]; then
    install_sources
fi

exec "$@"
