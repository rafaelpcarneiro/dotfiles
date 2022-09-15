#!/usr/bin/env bash


#|--- titanio_cluster on/off + some functions
titanio_cluster () {
    if [ $# -eq 0 ]; then
        echo "Argument empty is not valid. It must have as arguments the"
             "values (on/off)"
    else
        if [ $1 = "on" ]; then
            echo "Connecting to the Titanio cluster using IPV4"
            ssh -fN -L 9998:172.17.10.11:22 rafael.carneiro@hpc.ufabc.edu.br -4
            ssh -p 9998 rafael.carneiro@localhost  -4

        elif [ $1 = "off" ]; then
            echo "Disconnecting from the Titanio cluster..."

            local tunel_port_process=$(
                netstat -tulpn |
                grep "9998" |
                grep -o -P "\d+/ssh"|
                cut -d '/' -f 1
            )

            kill $tunel_port_process
            echo "Disconnected..."
            echo ""
        else
            echo "Arguments valid are: on/off"
        fi
    fi
}
