#!/usr/bin/env bash

pdftopng() {
    if [ $# -eq 0 ]; then
        echo "pdftopng must be followed by the flags below:"
        echo ""
        echo "-f filename"
        echo "    Mandatory flag with 'filename' as its value."
        echo "    --------------------------------------------"
        echo "    This flag sets which file must be converted to png;"
        echo ""
        echo "-t"
        echo "    Optional flag whose value is not needed."
        echo "    ----------------------------------------"
        echo "    This flag tells the script whether or not it should set the "
        echo "    background as transparent. In case the flag is not provided"
        echo "    then nothing is done regarding to the backgroung."
        echo ""
        echo "-r dim0xdim1"
        echo "    Optional flag whose value cannot be empty"
        echo "    -----------------------------------------"
        echo "    This flag tells the script to resize the original image so the"
        echo "    new image will be a matriz M of 'dim0' rows and 'dim1' colunmns."
        echo "    Note: row and column values must be separated by the char 'x' "
        echo "    and there must be none space between them."
        echo ""


    else
        local pdfFile=""
        local pdfName=""
        local transparency=""
        local resize=""
        while getopts "f:tr:"  flag; do
            case $flag in
                f) pdfFile="${OPTARG}"
                   pdfName=`expr "$pdfFile" : "\(.\+\).pdf"`
                   if [ -z "$pdfName" ]; then
                       echo "File must be a pdf"

                       #Reset OPTIND
                       OPTIND=0

                       return 1
                   fi
                   ;;
                t) transparency="-transparent white"
                   ;;
                r) resize="${OPTARG}"
                   dim0=`expr "$resize" : "\([0-9]\+\)x.*"`
                   dim1=`expr "$resize" : ".*x\([0-9]\+\)"`
                   if [[ -z $dim0 || -z $dim1 ]]; then
                       echo "Resize must be something like:"
                       echo "   1200x900 or 700x240 or ..."
                       echo "but cannot accept ${resize} as argument"

                       #Reset OPTIND
                       OPTIND=0

                       return 1
                   fi
                   resize="-resize ${resize}"
                   ;;
            esac
        done

        pdftoppm  $pdfFile -jpegopt quality=100 -jpeg $pdfName

        #convert ${file//.pdf/-1.jpg} -transparent white -resize 1100x400 ${file//pdf/png}
        convert "${pdfName}-1.jpg" \
                -quality 100       \
                $transparency      \
                $resize            \
                "${pdfName}.png"

        rm "${pdfName}"*.jpg

        #Reset OPTIND
        OPTIND=0
    fi
}

pdfExtractPage() {
    if [ $# -eq 0 ]; then
        echo "pdfExtractPage must be followed by the flags below:"
        echo ""
        echo "-f filename"
        echo "    Mandatory flag with 'filename' as its value."
        echo "    --------------------------------------------"
        echo "    This flag sets which file must be converted to png;"
        echo ""
        echo "-p"
        echo "    Mandatory flag with 'page int number' as its value."
        echo "    ---------------------------------------------------"
        echo "    This flag tells the script which page should be cropped"
        echo "    from the file"
        echo ""
        echo "Description"
        echo "-----------"
        echo "This script will extract an specific page from the filename"
        echo "given by -f and it will output a file named as \"out_pg${pg}.pdf\""
        echo ""

    else
        local pdfFile=""
        local pdfName=""
        local pg=""
        local pg_check=""

        while getopts "f:p:"  flag; do
            case $flag in
                f) pdfFile="${OPTARG}"
                   pdfName=`expr "$pdfFile" : "\(.\+\).pdf"`
                   if [ -z "$pdfName" ]; then
                       echo "File must be a pdf"

                       #Reset OPTIND
                       OPTIND=0

                       return 1
                   fi
                   ;;
                p) pg="${OPTARG}"
                   pg_check=`expr "${pg}" : "^\([0-9]\+\)$"`
                   if [ -z ${pg_check} ]; then
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

}

pdfMergeFiles() {
    if [ $# -eq 0 ]; then
        echo "pdfMergePages must be followed by the flags below:"
        echo ""
        echo "-o"
        echo "    Mandatory flag whose value will will be a filename"
        echo "    ---------------------------------------------------------"
        echo "    This flag dictates which name the pdf created will have"
        echo ""
        echo "Description"
        echo "-----------"
        echo "This script will merge many pdf files into one."
        echo "It is used as the following way:"
        echo "  pdfMergePages  -o testMerged.pdf \ "
        echo "                 file1.pdf file2.pdf ... fileN.pdf "
        echo "which will merge file1.pdf file2.pdf ... into testMerged.pdf"
        echo ""

    else
        local pdfFile=""
        local pdfName=""

        while getopts "o:"  flag; do
            case $flag in
                o) pdfFile="${OPTARG}"
                   pdfName=`expr "$pdfFile" : "\(.\+\).pdf"`
                   if [ -z "$pdfName" ]; then
                       echo "File must be a pdf"

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

        #Reset OPTIND
        OPTIND=0
    fi

}
