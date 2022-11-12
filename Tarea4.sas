*Lo primero que hicimos fue subir nuestros datasets que encontramos a SAS en este caso fueron dos
Clientes y Autos que se relacionan por la compra de algun modelo de autos*;
Data Clientes;
infile '/home/u62036160/sasuser.v94/Test.csv ' DSD MISSOVER FIRSTOBS=2;
INPUT ID Gender$ Ever_Married$ Age Graduated$ Profession$ Work_Experience Spending_Score$ Family_Size Car$;
RUN;

Data Autos;
infile '/home/u62036160/sasuser.v94/CAR DETAILS FROM CAR DEKHO.csv ' DSD MISSOVER FIRSTOBS=2;
INPUT Car$ Year Selling_Price Km_Driven Fuel$ Seller_Type$ Transmission$ Owner$;
RUN;
*Posteriormente como no queremos trabajar por separado las tablas, las juntamos en una 
nueva que llamamos Ventas*;
PROC SORT DATA=Clientes; By Car; Run;
PROC SORT DATA=Autos; By Car; Run;
DATA Ventas;
MERGE Clientes Autos;
BY CAR;
RUN;

*Ahora generamos un resumen de cada tabla donde nos indica sus respectivas caracteristicas*;
proc contents data=Autos; run;

proc contents data=Clientes; run;

proc contents data=Ventas; run;

*Aqui creamos una nueva tabla con una condicion en la culumna Selling_Price*;
data  Ventas_Precio;
     set Ventas(where=(Selling_Price<=400000));
     run;
     
*Tambien creamos una columna para comprarar el modelo de autos con su respectivo precio y 
en que trabaja la persona que lo compro*;
data Precio_Auto(keep=Car  Selling_Price Gender );
      set Ventas;
run;

*Finalmente creamos otra tabla que nos muestra desde el coche mas caro hasta el mas barato*;
proc sort data=Ventas output=Precio_Mas_Menos;
     by descending Selling_Price;
run;
     
     