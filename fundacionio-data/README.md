# Datos Fundación IO

Obtención de los datos que está recopilando Fundación IO sobre COVID19

Disponibles en:

 - https://covid19.fundacionio.com/awsPostalCodesCasesByDay.aspx?WSDL
 - https://covid19.fundacionio.com/aAllDataServices.aspx?WSDL

# Para ejecutar y descargar los PostalCodesCasesByDay:

1. Instalar zeep:

''pip install zeep

(Más info sobr zeep en https://python-zeep.readthedocs.io/en/master/)

2. Ejecutar script: 

''python download-PostalCodesCasesByDay.py > PostalCodesCasesByDay-<YYYYMMDDHHMM>.json

*ATENCIÓN*: Alguno de los datos que descargan tienen fecha incorrecta.
Se ha comunicado a Fundación IO el 24-03-2020 y van a estudiar el problema
