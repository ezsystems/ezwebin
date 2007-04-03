#!/bin/sh

#
# Usage: - put 'ezwebin' extension to <ezp_dir>/extensions
#        - run ./bin/repack_extension.sh --with-ezp=<ezp_dir>
#        - you will find created 'ezwebin_extension' package(uncompressed) in <ezp_dir>/var/storage/packages/local/
#

function show_help
{
    echo
    echo "The script will recreate package for ezwebin extension."
    echo
    echo "Usage: $0 <options>"
    echo "      - put 'ezwebin' extension to <ezp_dir>/extensions"
    echo "      - run ./bin/repack_extension.sh --with-ezp=<ezp_dir>"
    echo "      - you will find created 'ezwebin_extension' package(uncompressed) in <ezp_dir>/var/storage/packages/local/"

    echo
    echo "Options: -h"
    echo "         --help                     This message"
    echo "         --with-ezp=<path>          Path to eZ publish installation to use"
    echo
}

function parse_cl_parameters
{
    [ -z "$*" ] && show_help && exit 1
    for arg in $*; do
        case $arg in

        --help|-h)
            show_help
            exit 1
            ;;

        --with-ezp*)
            if echo $arg | grep -e "--with-ezp=" >/dev/null; then
                EZPUBLISH_DIR=`echo $arg | sed 's/--with-ezp=//'`
            fi
            ;;

        --*)
            if [ $? -ne 0 ]; then
                echo "$arg: unknown long option specified"
                echo
                echo "Type '$0 --help\` for a list of options to use."
                exit 1
            fi
            ;;
        -*)
            if [ $? -ne 0 ]; then
                echo "$arg: unknown option specified"
                echo
                echo "Type '$0 --help\` for a list of options to use."
                exit 1
            fi
            ;;
        *)
                echo "Type '$0 --help\` for a list of options to use."
                exit 1
            ;;
        esac;
    done
}

## main ################################################

# "Declare" all the variables used in the script.
EZPUBLISH_DIR=""
PACKAGE_DIR=""
PACKAGE_NAME="ezwebin_extension"

# parse and check options
parse_cl_parameters $*

if [ ! -d "$EZPUBLISH_DIR" ]; then
    echo "eZ publish installation '$EZPUBLISH_DIR' doesn't exist"
    exit 1
fi

PACKAGE_DIR="$EZPUBLISH_DIR/var/storage/packages/local"

# Do the work.
cd "$EZPUBLISH_DIR"
./ezpm.php create $PACKAGE_NAME 'ezwebin extension' '1.1-1' 'install'
./ezpm.php add $PACKAGE_NAME ezextension ezwebin
./ezpm.php set $PACKAGE_NAME 'vendor' 'eZ systems'
./ezpm.php set $PACKAGE_NAME 'description' 'ezwebin extension'
./ezpm.php set $PACKAGE_NAME 'type' 'extension'
./ezpm.php set $PACKAGE_NAME 'state' 'stable'

