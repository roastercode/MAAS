#!/bin/bash


while [ "$1" != "" ]; do
        case "$1" in
        ###########
        # OPTIONS #
        ###########
          -A)
                NO_AGENT=1
                shift
                  ;;
          -m*)  # -m0 .. -m999
                CONCURRENT="${1#-m}"
		if [ -z "$CONCURRENT" -a "${2#-?*}" = "$2" ] ; then
			CONCURRENT=$2
			shift
		elif [ -z "$CONCURRENT" ] ; then
			CONCURRENT=0
		fi
		if [ "${CONCURRENT//[^0-9]/}" != "$CONCURRENT" ] ; then
			echo "Arguement should be numeric: $CONCURRENT" 1>&2
			exit 1
		fi
		shift
echo "Concurrency: $CONCURRENT"
                  ;;
          -d*)
                DEBUG="${1#-d}"
	        if [ -z "$DEBUG" -a "${2#-?*}" = "$2" ] ; then 
                        DEBUG=$2 
                        shift 
                elif [ -z "$DEBUG" ] ; then 
                        DEBUG=1 
                fi 
                if [ "${DEBUG//[^0-9]/}" != "$DEBUG" ] ; then 
                        echo "Arguement should be numeric: $DEBUG" 1>&2 
                        exit 1 
                fi 
                shift
echo "Debug: $DEBUG"
                  ;;
          -v*)
                TMP_ARG="${1#-v}"
	        if [ -z "$TMP_ARG" -a "${2#-?*}" = "$2" ] ; then 
                        TMP_ARG=$2 
                        shift 
                elif [ -z "$TMP_ARG" ] ; then 
                        TMP_ARG=1 
                fi 
                if [ "${TMP_ARG//[^0-9]/}" != "$TMP_ARG" ] ; then 
                        echo "Arguement should be numeric: $TMP_ARG" 1>&2 
                        exit 1 
                elif [ "${TMP_ARG//[^0-3]/}" != "$TMP_ARG" ] ; then 
                        echo "Arguement should be between 0 and 3: $TMP_ARG" 1>&2 
                        exit 1 
                fi 
                SSH_VERBOSE="-v"
                [ "$TMP_ARG" -ge 2 ] && SSH_VERBOSE="$SSH_VERBOSE -v"
                [ "$TMP_ARG" -ge 3 ] && SSH_VERBOSE="$SSH_VERBOSE -v"
                shift
echo "Verbosity: $SSH_VERBOSE"
                  ;;
          -h)
                while [ "$2" != "" -a "${2#-?*}" = "$2" ] ; do
                          HOSTLIST="$2
$HOSTLIST"
                        shift
                done
                shift
                  ;;
          *)
                echo "mussh: invalid command - \"$1\"" 1>&2
                #exit 1
		shift
                ;;
        esac
done

