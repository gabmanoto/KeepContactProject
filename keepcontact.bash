#!/bin/bash
keepcontact() { #! si l'argument correspond au nom d'une fonction alors executer le programme concerné.
    if [ "$1" == "add" ]; then
    add
    fi
    

    if [ "$1" == "list" ]; then
    list
    fi

    if [ "$1" == "edit" ]; then
    edit
    fi

    if [ "$1" == "search" ]; then
    search
    fi
}

#! question 1
add() {
    lastName=''
    firstName=''
    mail=''
    phoneNumber=''
    
    read -p 'Entrez votre prenom : ' firstName 
    read -p 'Entrez votre nom : ' lastName 
    read -p 'Entrez votre mail : ' mail 
    read -p 'Entrez votre numéro de téléphone : ' phoneNumber 

    firstName=$(echo "$firstName" | tr '[:upper:]' '[:lower:]') # Transforme les majuscules en minuscules

    lastName=$(echo "$lastName" | tr '[:upper:]' '[:lower:]')
    
    mail=$(echo "$mail" | tr '[:upper:]' '[:lower:]')

    phoneNumber=$(echo "$phoneNumber" | tr -cd '0-9') #supprime tout ce qui n'est pas un chiffre.


    
    

    #if ! expr index @ "$mail"; <== pour voir si un mail sans @ est refusé.
    
    
    
    if grep -q "|$mail%" "contact.bash" ; #! si le mail est présent dans le fichier alors:
    then
        echo "Veuillez mettre un autre mail"


        elif grep -q "%$phoneNumber|" "contact.bash" ; #! si le numéro de tel est présent dans le fichier alors:
        then
            echo "Veuillez mettre un autre numéro de téléphone"


            else
                echo "Le contact a été ajouté."
                echo "$firstName,$lastName|$mail%$phoneNumber|" >> contact.bash
                
    fi    
}

#! question 2
list(){
    id=0

        while read line 
        do
        ((id=id+1)); #! à chaque lecture de ligne on incrément $id
        echo -e "[id $id] $line " | sed "s/,/   /g" | sed "s/%/   /g" | sed "s/|/   /g"  #!sed "s/,/   /g"--> permet d'enlever les ',' et remplace par une tabulation 
        done < contact.bash

}

#! question 3
edit(){
    id=''
    lastName=''
    firstName=''
    mail=''
    phoneNumber=''
    switch=''
    boucle=0

    read -p "Entrez l'id du contact : " id
    read -p 'Entrez votre prenom : ' firstName 
    read -p 'Entrez votre nom : ' lastName 
    read -p 'Entrez votre mail : ' mail 
    read -p 'Entrez votre numéro de téléphone : ' phoneNumber 

    firstName=$(echo "$firstName" | tr '[:upper:]' '[:lower:]')

    lastName=$(echo "$lastName" | tr '[:upper:]' '[:lower:]')
    
    mail=$(echo "$mail" | tr '[:upper:]' '[:lower:]')

    phoneNumber=$(echo "$phoneNumber" | tr -cd '0-9')
    while read line
    do
        ((boucle=boucle+1));
        if [ ! "$boucle" = "$id" ] ;
        then
            if [[ "$line" == *"|$mail%"* ]];
            then
                switch="mail"


                elif [[ "$line" == *"%$phoneNumber|"* ]]  ; 
                then
                    switch="phoneNumber"
            fi              
        fi
    done < contact.bash

    if [ "$switch" = "mail" ] ;
    then 
        echo "Veuillez mettre un autre mail"
        elif [ "$switch" = "phoneNumber" ] ;
        then
            echo "Veuillez mettre un autre numéro"
        else 
            sed -i "${id}s/.*/$firstName,$lastName|$mail%$phoneNumber|/" contact.bash

    fi
}

#! question 4
search(){
    search=''

    read -p 'Recherche : ' search 
    search=$(echo "$search" | tr '[:upper:]' '[:lower:]')

    grep "$search" "contact.bash" | sed "s/,/   /g" | sed "s/%/   /g" | sed "s/|/   /g" ;
}







keepcontact $1