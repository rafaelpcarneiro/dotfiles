#!/usr/bin/env sh

#### Check if inkscape and convert are installed
if [ -z "$(whereis -q inkscape)" ]; then
    echo "Please install inkscape if you want this script to work properly "

    return 1
fi
if [ -z "$(whereis -q convert)" ]; then
    echo "Please install convert if you want to resize the image "
    echo "convert is a program of the ImageMagick package if I am not mistaken"

    return 1
fi

### Program help


if [ $# -eq 0 ]; then
cat <<EOF

pdftopng  accepts as arguments the flags:

    -f filename
        [Mandatory] flag with 'filename' as its value.
        ----------------------------------------------

        This flag sets which file must be converted to png;


    -t
        [Optional] flag whose value is a number between [0,1].
        ------------------------------------------------------

        This flag tells the script whether or not it should set the background
        as transparent. In case the flag is not provided, then nothing is done
        regarding to the backgroung.
        Obs: The closer to zero the more transparent the background will be!


    -r dim0xdim1
        [Optional] flag whose value cannot be empty
        --------------------------------------------

        This flag tells the script to resize the original image so the  new
        image will be a matriz M of 'dim0' rows and 'dim1' colunmns.

        Note: row and column values must be separated by the char 'x' and there
        must be none space between them.


EOF


else
    pdfFile=""
    pdfName=""
    transparency=1
    resize=""
    while getopts "f:t:r:"  flag; do
        case $flag in
            f) pdfFile="${OPTARG}"
               pdfName=`expr "$pdfFile" : "\(.*\).pdf"`
               if [ -z "$pdfName" ]; then
                   echo "File must be a pdf"

                   #Reset OPTIND
                   OPTIND=0

                   return 1
               fi
               ;;

            t) transparency="${OPTARG}"
               transparency=`expr "${transparency}" : "\([01]\.\{0,1\}[0-9]\{0,\}\)"`
               if [ -z "$transparency" ]; then
                   echo "-t value must be a value between the interval [0, 1]"

                   #Reset OPTIND
                   OPTIND=0

                   return 1
               fi
               ;;

            r) resize="${OPTARG}"
               dim0=`expr "$resize" : "\([0-9]\{1,\}\)x.*"`
               dim1=`expr "$resize" : ".*x\([0-9]\{1,\}\)"`
               if [ -z $dim0 ] || [ -z $dim1 ]; then
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

    inkscape $pdfFile \
        --export-background-opacity=$transparency \
        --export-type=png \
        --export-dpi=600  \
        --export-filename="${pdfName}.png"

    if [ -n "$resize" ]; then
        convert "${pdfName}.png" \
            -quality 100       \
            $resize            \
            "${pdfName}.png"
    fi


    #Reset OPTIND
    OPTIND=0
fi
