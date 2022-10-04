#!/usr/bin/env sh


if [ $# -eq 0 ]; then
cat <<EOF

pdfExtractPage accepts  the following arguments:

    -f filename
        [Mandatory] flag with 'filename' as its value.
        ----------------------------------------------

        This flag sets which file must be converted into png;

    -p
        [Mandatory] flag with 'page int number' as its value.
        -----------------------------------------------------

        This flag tells the script which page should be cropped from the file


    Description
    -----------
    This script will extract an specific page from a filename, given by -f, and
    it will output a file, named as \out_pg${pg}.pdf\



EOF

else
    pdfFile=""
    pdfName=""
    pg=""
    pg_check=""

    while getopts "f:p:"  flag; do
        case $flag in
            f) pdfFile="${OPTARG}"
                echo "${pdfFile}"
                pdfName=$(expr "${pdfFile}" : "\(.*\).pdf")
                echo "${pdfName}"
                if [ -z "$pdfName" ]; then
                    echo "File must be a non empty pdf"

                    #Reset OPTIND
                    OPTIND=0

                    return 1
                fi
                ;;
            p) pg="${OPTARG}"
                pg_check=`expr "${pg}" : "^\([0-9]*\)$"`
                if [ -z "${pg_check}" ] || [ $pg_check -eq 0 ]; then
                    echo "-pg must be a positive integer!!!"
                    echo "It cannot accept ${pg} as argument"

                    #Reset OPTIND
                    OPTIND=0

                    return 1
                fi
                ;;
        esac
    done

    gs -sDEVICE=pdfwrite           \
        -dNOPAUSE -dBATCH          \
        -sPageList=$pg             \
        -sOutputFile="out_pg${pg}.pdf" \
        $pdfFile

    #Reset OPTIND
    OPTIND=0
fi
