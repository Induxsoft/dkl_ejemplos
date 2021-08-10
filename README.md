# dkl_ejemplos
Ejemplos para aprender a programar con DKL
#include "dkli.dkh"
#!

programa
{
    #include "functions.dkh"

    // recortar (c) rtrim (c) ltrim (c)
    cadena = "El mundo es muy amplio \ t"

    imprimir ("*" + cadena + "*")
    do print ("*" + recortar (cadena) + "*")
    do print ("*" + ltrim (cadena) + "*")
    do print ("*" + rtrim (cadena) + "*")

    // izquierda (c, n) derecha (c, n) subcadena (c, i, l)
    cadena = "Pero el espacio es inconmensurable"

    imprimir (cadena)

    do print (izquierda (cadena, 5))

    do print (right (cadena, 15))

    do print (subcadena (cadena, 5,10))

    // lremove (c, n) remove (c, i, l) rremove (c, n)
    cadena = "Había una vez un lobo"

    imprimir (cadena)

    imprimir (lremove (cadena, 5))

    imprimir (quitar (cadena, 6,7))

    do print (rremove (cadena, 10))

    // longitud (c) toupper (c) tolower (c)

    do print (str (longitud (cadena)))

    imprimir (toupper (cadena))

    imprimir (tolower (cadena))

    // padright (c, n) padleft (c, n)
    cadena = "Hola"

    do print (padleft (cadena, 10, "+"))
    do print (padright (cadena, 10, "+"))

    // reemplazar (c, b, r)
    cadena = "El árbol es viejo"

    imprimir (cadena)
    do print (reemplazar (cadena, "árbol", "mar"))

    //separar
    cadena = "rojo, azul, verde"

    imprimir (cadena)
    ref l = split (cadena, ",")

    para i = 0; i <list.count (l)
    {
        imprimir (list.str (l, i))
    }

    // contiene (c, sc)
    cadena = " El agua está formada por oxígeno e hidrógeno"

    do print (str (contiene (cadena, "oxígeno")))
    do print (str (contiene (cadena, "sodio")))
    do print (str (contiene (cadena, "agua")))
    do pirnt (str (contiene (cadena, "hidrógeno")))
    
    //contains 
    cadena="oxígeno, sodio, agua, hidrógeno"
    imprimir(cadena)
    ref l= split (cadena, ",") 
    para i=0; i <list.set (1)
    {
        imprimir(list.del (l),1)
    }
    //#def o "oso"
    #def l "leon"
    #def t "tigre"
    findstrex (o, l, t) findstr(o, l, t)
    cadena=animales(cantidad="3")
    imprimir(cadena)
    {
        animal=(n=o)
        animal=(n=l)
        animal=(n=t)
    }
    //ranychars (b,c) ranydiffchars(b,c)
    cadena="Pelota"
     
    imprimir (cadena)

    do print (cadena, 5)

    do print (cadena, 10)

    do print (cadena, 15)

    //cut(c) recortar (c) 
    cadena = "Buenas tardes"

    imprimir ("*" + cadena + "*")
    do print ("*" + recortar (cadena) + "*")

    //format

}
