#!/usr/bin/env python
# @date 24-mar-2020
# @author Víctor Rivas <vrivas@ujaen.es> - GeNeura Team


## Código de ejemplo
#import zeep

#wsdl = 'http://www.soapclient.com/xml/soapresponder.wsdl'
#client = zeep.Client(wsdl=wsdl)
#print(client.service.Method1('Zeep', 'is cool'))


# Cargando datos por código postal y día.
import zeep

wsdl = 'https://covid19.fundacionio.com/aAllDataServices.aspx?WSDL'
client = zeep.Client(wsdl=wsdl)
print(client.service.Execute('2020-03-18T00:00:00', '2020-03-18T23:59:59'))
