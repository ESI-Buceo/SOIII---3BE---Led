#!/bin/bash
#-------------------------- VARIABLES ------------------------------
F=4
CantidadErrores=1
FECHA=
HORA=
USUARIO=
#-------------------------------------------------------------------
clear
echo -e "==================== BLOQUEAR USUARIO =================="
echo ""

while [ "$F" -eq 4 ]
do
read -p "Ingrese el nombre del Usuario a modificar:     "    NAME
UserName=$NAME
if grep -qwis $NAME /etc/passwd
then
	read -p "Seguro desea bloquear al usuario $UserName ?  Y/n "  OPCION
        case $OPCION in
        Y|y)
            if sudo usermod -L $UserName
            then
                echo "Usuario bloqueado con exito!"
		FECHA=$(date +'%A %d de %B de %Y')
		HORA=$(date +%T)
		USUARIO=$(whoami)
		echo "$USUARIO bloqueo a $UserName el $FECHA a las $HORA hs" >> logbloqueousuario.txt

		F=3
            else    
                echo "Error al bloquear al usuario :("
		CantidadErrores=$((CantidadErrores+1))
        	if [ "$CantidadErrores" -eq 4 ]
        	then
                clear
                echo -e "Ha superado la cantidad de intentos permitidos"
                sleep 2
                F=3
        	fi
            fi
        ;;
        N|n)
            F=3
        ;;
        *)
            echo Opcion incorrecta
		CantidadErrores=$((CantidadErrores+1))
        	if [ "$CantidadErrores" -eq 4 ]
       		then
                clear
                echo -e "Ha superado la cantidad de intentos permitidos"
                sleep 2
                F=3
        	fi
        ;;
        esac
else
	echo -e "Nombre de usuario Incorrecto"
	CantidadErrores=$((CantidadErrores+1))
        if [ "$CantidadErrores" -eq 4 ]
        then
                clear
                echo -e "Ha superado la cantidad de intentos permitidos"
                sleep 2
                F=3
        fi
fi
done
sleep 1
./MenuModUser.sh
