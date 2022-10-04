#!/usr/bin/env sh


if [ $# -eq 0 ]; then
cat <<EOF

pdfMergePages accepts the following arguments:

    -o
        [Mandatory] flag whose value will will be a filename
        ---------------------------------------------------------

        This flag dictates which name the pdf created will have


    Description
    -----------
    This script will merge many pdf files into one.  It is used as the following
    way:
      pdfMergePages  -o testMerged.pdf \
                     file1.pdf file2.pdf ... fileN.pdf

    This command  will merge file1.pdf file2.pdf ... into testMerged.pdf


EOF

else
    pdfFile=""
    pdfName=""

    while getopts "o:"  flag; do
        case $flag in
            o) pdfFile="${OPTARG}"
                pdfName=`expr "$pdfFile" : "^\(.*\).pdf$"`
                if [ -z "$pdfName" ]; then
                    echo "File must be a non empty pdf"

                    #Reset OPTIND
                    OPTIND=0

                    return 1
                fi
                ;;
        esac
    done

    shift $((OPTIND - 1))
    # Using shift operator!!!
    # Ex:
    #      shift N
    # takes the list $@ and throws away
    # all elements from 0 to N, resting only elements
    # starting from N+1 up to END

    gs  -sDEVICE=pdfwrite     \
        -dNOPAUSE             \
        -dBATCH               \
        -sOutputFile=$pdfFile \
        $@

    # Reset OPTIND
    OPTIND=0
fi
