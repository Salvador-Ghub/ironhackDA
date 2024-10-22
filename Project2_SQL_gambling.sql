use gambling;

-- Pregunta 01: Usando la tabla o pestaña de clientes, 
-- por favor escribe una consulta SQL que muestre Título, Nombre y Apellido y Fecha de Nacimiento para cada uno de los clientes. No necesitarás hacer nada en Excel para esta.

select Title, FirstName, LastName, DateOfBirth from customer;

-- Pregunta 02: Usando la tabla o pestaña de clientes, por favor escribe una consulta SQL que muestre el número de clientes en cada grupo de clientes (Bronce, Plata y Oro). 
-- Puedo ver visualmente que hay 4 Bronce, 3 Plata y 3 Oro pero si hubiera un millón de clientes ¿cómo lo haría en Excel?

select CustomerGroup, COUNT(*) from customer
group by CustomerGroup;

-- Pregunta 03: El gerente de CRM me ha pedido que proporcione una lista completa de todos los datos para esos clientes en la tabla de clientes pero necesito añadir 
-- el código de moneda de cada jugador para que pueda enviar la oferta correcta en la moneda correcta. Nota que el código de moneda no existe en la tabla de clientes sino en la tabla de cuentas. 
-- Por favor, escribe el SQL que facilitaría esto. ¿Cómo lo haría en Excel si tuviera un conjunto de datos mucho más grande?

select * from customer as cus
join account as acc
on acc.AccountLocation = cus.AccountLocation;

/* Pregunta 04: Ahora necesito proporcionar a un gerente de producto un informe resumen que muestre, por producto y por día, cuánto dinero se ha apostado en un producto particular. 
TEN EN CUENTA que las transacciones están almacenadas en la tabla de apuestas y hay un código de producto en esa tabla que se requiere buscar (classid & categoryid) 
para determinar a qué familia de productos pertenece esto. Por favor, escribe el SQL que proporcionaría el informe. Si imaginas que esto fue un conjunto de datos mucho más 
grande en Excel, ¿cómo proporcionarías este informe en Excel? */

create or replace view day_bet_product as
select bet.BetDate, pro.product, sum(bet.Bet_Amt) as totalAmount from betting as bet
join product as pro
on bet.ClassId = pro.CLASSID and bet.CategoryId = pro.CATEGORYID
group by pro.product, bet.BetDate
order by bet.BetDate asc;

select * from day_bet_product;

/* Pregunta 05: Acabas de proporcionar el informe de la pregunta 4 al gerente de producto, ahora él me ha enviado un correo electrónico y quiere que se cambie. 
¿Puedes por favor modificar el informe resumen para que solo resuma las transacciones que ocurrieron el 1 de noviembre o después y solo quiere ver transacciones de Sportsbook. 
Nuevamente, por favor escribe el SQL abajo que hará esto. Si yo estuviera entregando esto vía Excel, ¿cómo lo haría? */

select * from day_bet_product
where BetDate >= '2012-11-01 00:00:00' AND product = 'Sportsbook';

/* Pregunta 06: Como suele suceder, el gerente de producto ha mostrado su nuevo informe a su director y ahora él también quiere una versión diferente de este informe. 
Esta vez, quiere todos los productos pero divididos por el código de moneda y el grupo de clientes del cliente, en lugar de por día y producto. 
También le gustaría solo transacciones que ocurrieron después del 1 de diciembre. Por favor, escribe el código SQL que hará esto. */

create or replace view acc_bet as
select acc.CustID, acc.CurrencyCode, bet.Bet_Amt from betting as bet
join account as acc
on bet.AccountNo = acc.AccountNo
where BetDate >= '2012-12-01 00:00:00';

select * from acc_bet;

create or replace view acc_bet_cus as
select abet.CurrencyCode, cust.CustomerGroup, sum(abet.Bet_Amt) as totalAmount from acc_bet as abet
join customer as cust
on abet.CustID = cust.CustId
group by abet.CurrencyCode, cust.CustomerGroup
order by totalAmount desc;

select * from acc_bet_cus;

/* Pregunta 07: Nuestro equipo VIP ha pedido ver un informe de todos los jugadores independientemente de si han hecho algo en el marco de tiempo completo o no. 
En nuestro ejemplo, es posible que no todos los jugadores hayan estado activos. Por favor, escribe una consulta SQL que muestre a todos los 
jugadores Título, Nombre y Apellido y un resumen de su cantidad de apuesta para el período completo de noviembre. */

create or replace view bet_nov as
select * from betting
where BetDate >= '2012-11-01 00:00:00' AND BetDate <= '2012-11-30 00:00:00';

select * from bet_nov;

create or replace view bet_account_nov as
select acc.CustId, bet.Bet_Amt from bet_nov as bet
join account as acc
on acc.AccountNo = bet.AccountNo;

select * from bet_account_nov;

create or replace view bet_account_nov_cust as
select cust.Title, cust.FirstName, cust.LastName, sum(bet.Bet_Amt) as NovBet from bet_account_nov as bet
join customer as cust
on bet.CustId = cust.CustId
group by cust.Title, cust.FirstName, cust.LastName;

select * from bet_account_nov_cust;

/* Pregunta 08: Nuestros equipos de marketing y CRM quieren medir el número de jugadores que juegan más de un producto. 
¿Puedes por favor escribir 2 consultas, una que muestre el número de productos por jugador y otra que muestre jugadores que juegan tanto en Sportsbook como en Vegas? */

create or replace view bet_acc as
select acc.CustId, bet.ClassId, bet.CategoryId from betting as bet
join account as acc
on bet.AccountNo = acc.AccountNo;

select * from bet_acc;

-- Primera consulta
select ba.CustId, count(DISTINCT ba.ClassId) from bet_acc as ba
group by ba.CustId;

create or replace view bet_acc_prod as
select CustId, p.product from bet_acc as ba
join product as p
where p.CLASSID = ba.ClassId and p.CATEGORYID = ba.CategoryId;

select * from bet_acc_prod;

-- Segunda consulta
select distinct CustId, product from bet_acc_prod
where product = 'Vegas' or product = 'Sportsbook'
order by CustId;


/* Pregunta 09: Ahora nuestro equipo de CRM quiere ver a los jugadores que solo juegan un producto, 
por favor escribe código SQL que muestre a los jugadores que solo juegan en sportsbook, usa bet_amt > 0 como la clave. 
Muestra cada jugador y la suma de sus apuestas para ambos productos. */

create or replace view bet_acc as
select acc.CustId, bet.ClassId, bet.CategoryId, bet.Bet_Amt from betting as bet
join account as acc
on bet.AccountNo = acc.AccountNo;

select * from bet_acc;

create or replace view bet_acc_prod_amt as
select CustId, p.product, ba.Bet_Amt from bet_acc as ba
join product as p
where p.CLASSID = ba.ClassId and p.CATEGORYID = ba.CategoryId;

select CustId, product, sum(Bet_Amt) from bet_acc_prod_amt
group by product, custId;

/*create or replace view custId_product_sumAmt as
select CustId, product, sum(Bet_Amt) as SumAmt from bet_acc_prod_amt
group by product, CustId;

select * from custId_product_sumAmt
order by CustId;*/

create or replace view custId_product_sumAmt_SiSport as
select CustId, product, sum(Bet_Amt) as SumAmt from bet_acc_prod_amt
group by product, CustId
having product = 'Sportsbook';

select * from custId_product_sumAmt_SiSport;

create or replace view custId_product_sumAmt_NoSport as
select CustId, product, sum(Bet_Amt) as SumAmt from bet_acc_prod_amt
group by product, CustId
having product != 'Sportsbook';

select * from custId_product_sumAmt_NoSport;

/*create or replace view cust_noSport as
select CustId, count(product) as Suma, sum(SumAmt) from custId_product_sumAmt_NoSport
group by CustId;

select * from cust_noSport;*/
-- solo falta eliminar de la tabla principal los customers que aparezcan en cust_noSport así tendremos solo los que únicamente juegan a Sport.


create or replace view vista_filtrada as
select *
from custId_product_sumAmt_SiSport
where CustId not in (select CustId from custId_product_sumAmt_NoSport);

select * from vista_filtrada;


/* Pregunta 10: La última pregunta requiere que calculemos y determinemos el producto favorito de un jugador. 
Esto se puede determinar por la mayor cantidad de dinero apostado. Por favor, escribe una consulta que muestre el producto favorito de cada jugador*/

create or replace view bet_acc as
select acc.CustId, bet.ClassId, bet.CategoryId, bet.Bet_Amt from betting as bet
join account as acc
on bet.AccountNo = acc.AccountNo;

select * from bet_acc;

create or replace view bet_acc_prod_amt as
select CustId, p.product, p.CLASSID, p.CATEGORYID, ba.Bet_Amt from bet_acc as ba
join product as p
where p.CLASSID = ba.ClassId and p.CATEGORYID = ba.CategoryId;

create or replace view custId_prod_BetAmt as
select CustId, product, CLASSID, CATEGORYID, sum(Bet_Amt) as BetProd from bet_acc_prod_amt
group by product, custId, CLASSID, CATEGORYID
order by custId, BetProd desc;

create or replace view custId_prod_BetAmt_ranking as
SELECT *, DENSE_RANK() OVER(PARTITION BY CustId ORDER BY BetProd DESC) AS 'Rank'
FROM custId_prod_BetAmt;

select * from custId_prod_BetAmt_ranking as crank
where crank.Rank = '1'
order by crank.CustId asc;

/* Mirando los datos abstractos en la pestaña "Student_School" en la hoja de cálculo de Excel, por favor responde las siguientes preguntas:

Pregunta 11: Escribe una consulta que devuelva a los 5 mejores estudiantes basándose en el GPA */

select * , dense_rank() over(order by GPA desc) as 'GPA Rank'
from student
limit 5;

/* Pregunta 12: Escribe una consulta que devuelva el número de estudiantes en cada escuela. (¡una escuela debería estar en la salida incluso si no tiene estudiantes!) */

create or replace view students_school as
select sc.school_name, count(st.student_id) as students from school as sc
left join student as st
on sc.school_id = st.school_id
group by sc.school_name
order by students desc;

select * from students_school;


/* Pregunta 13: Escribe una consulta que devuelva los nombres de los 3 estudiantes con el GPA más alto de cada universidad. */


create or replace view student_school_view as
select st.student_id, st.student_name, st.city, st.school_id, st.GPA, sc.school_name, sc.city as SchoolCity from student as st
join school as sc
where st.school_id = sc.school_id;

select student_name, school_name, GPA, dense_rank() over(partition by school_id order by GPA desc) as 'GPA Rank'from student_school_view
where 'GPA Rank' <= 3;





