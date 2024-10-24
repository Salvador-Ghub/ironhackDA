-- LEVEL 1

-- Question 1: Number of users with sessions

select count(distinct user_id) as 'UsuariosConSesiones' from sessions
where user_id is not null;

-- Question 2: Number of chargers used by user with id 1

select user_id, count(charger_id) from sessions
group by user_id
having user_id = 1;

-- LEVEL 2

-- Question 3: Number of sessions per charger type (AC/DC):
drop view session_type;
create view session_type as
select s.id, s.user_id, s.charger_id, c.type from sessions as s
join chargers as c
on c.id = s.charger_id;

select type, count(id) as total from session_type
group by type;


-- Question 4: Chargers being used by more than one user

select s.charger_id, count(s.user_id) as Usuarios from sessions as s
group by charger_id
having Usuarios > 1;


-- Question 5: Average session time per charger
-- (avg(DATE_FORMAT(CONVERT(s.end_time,DATE), '%y-%M-%d %H:%m:%s')

/*select s.charger_id, round(avg(DATE_FORMAT(CONVERT(s.end_time,DATE), '%y-%M-%d %H:%m:%s')  -DATE_FORMAT(CONVERT(s.start_time,DATE), '%y-%M-%d %H:%m:%s') )) from sessions as s
group by charger_id;*/

select * from sessions;

select s.charger_id, round(avg(julianday(s.end_time) - julianday(s.start_time))* 24 * 60,2) as minutes from sessions as s
group by charger_id;

-- LEVEL 3

-- Question 6: Full username of users that have used more than one charger in one day (NOTE: for date only consider start_time)

drop view session_day;
create view session_day as
select count(id) as vecesDia, user_id, charger_id, strftime('%Y-%m-%d',start_time) as date from sessions
group by user_id, date, charger_id
having vecesDia;

drop view users_usos;
create view users_usos as
select user_id, date, count(*) cargadoresDia from session_day
group by user_id, date
having cargadoresDia > 1;

select * from users_usos;

drop view users_repet;
create view users_repet as
select distinct user_id from users_usos;

select u.name, u.surname from users_repet as ur
join users as u
on ur.user_id = u.id;

-- Question 7: Top 3 chargers with longer sessions

select s.charger_id, max(round((julianday(s.end_time) - julianday(s.start_time))* 24 * 60,2)) as longerSession from sessions as s
group by charger_id
order by longerSession desc
limit 3;


-- Question 8: Average number of users per charger (per charger in general, not per charger_id specifically)
-- reutilizo el view de sesión y tipo de cargador

drop view charger_user;

create view charger_user as
select user_id, charger_id from session_type
group by user_id, charger_id
order by charger_id;

select * from charger_user;

drop view charger_user_count;

create view charger_user_count as
select charger_id, count(user_id) as count_us from charger_user
group by charger_id;

select avg(cu.count_us) as average from charger_user_count as cu;

-- Question 9: Top 3 users with more chargers being used

select user_id, count(distinct charger_id) as cargadoresUsados from sessions
group by user_id
order by cargadoresUsados desc
limit 3;

-- LEVEL 4

-- Question 10: Number of users that have used only AC chargers, DC chargers or both

drop view codificado;

create view codificado as
select *, iif(type = 'AC', 1, 2) as cod from session_type
group by user_id, type;

select * from codificado;

/*select user_id, sum(cod) as 'OnlyAC = 1, OnlyDC = 2, Both = 3' from codificado
group by user_id;*/

select cod as 'OnlyAC = 1, OnlyDC = 2, Both = 3', count(user_id) as cantidad from (select user_id, sum(cod) as cod from codificado
group by user_id)
group by cod;


-- Question 11: Monthly average number of users per charger

select charger_id, month, avg(usuariosDiferentes)
from (select id, count(distinct user_id) as usuariosDiferentes, charger_id, strftime('%Y-%m',start_time) as month from sessions
group by charger_id, month) as average
group by charger_id, month;

-- Question 12: Top 3 users per charger (for each charger, number of sessions)

select * from (select user_id, charger_id, sesiones, dense_rank() over(partition by charger_id order by sesiones desc) as 'Rank' from
(select user_id, charger_id, count(id) as sesiones from sessions
group by user_id, charger_id)
order by charger_id, Rank)
where Rank <= 3;


-- LEVEL 5

-- Question 13: Top 3 users with longest sessions per month (consider the month of start_time)

select * from
(select *, dense_rank() over(partition by month order by length desc) as 'Rank' from
(select *, round((julianday(end_time) - julianday(start_time))* 24 * 60,3) as length, strftime('%Y-%m',start_time) as month from sessions))
where Rank <= 3
order by Rank;
    
-- Question 14. Average time between sessions for each charger for each month (consider the month of start_time)

select *, strftime('%Y-%m',start_time) as month from sessions
order by charger_id, start_time asc;

-- Respuesta marca en una columna si la fila tiene encima un cargador distinto al de esa fila 
select *, iif(lag(charger_id,1) over(order by charger_id, start_time asc) != charger_id, 1, 0) as unoInicial from (select *, strftime('%Y-%m',start_time) as month from sessions
order by charger_id, start_time asc);

/*select *, iif(unoInicial = 0, lag(end_time,1) over(order by charger_id, start_time asc) - start_time, 0) from
(select *, iif(lag(charger_id,1) over(order by charger_id, start_time asc) != charger_id, 1, 0) as unoInicial from 
(select *, strftime('%Y-%m',start_time) as month from sessions
order by charger_id, start_time asc));

/*select *, lag(end_time,1) over(order by charger_id, start_time asc) from sessions;*/

/*select *, dense_rank() over(partition by charger_id order by start_time asc), dense_rank() over(partition by charger_id order by end_time asc) from sessions;
select *, dense_rank() over(partition by charger_id order by end_time) from sessions;*/

-- Respuesta indica cuando tenemos un hueco temporal de desuso entre sesiones, inicio de fila actul y final de la anterior.
select *, iif(lag(end_time,1) over(order by charger_id, end_time asc) < start_time, 1, 0) as unoParo from (select *, strftime('%Y-%m',start_time) as month from sessions
order by charger_id, start_time asc);

/*select *, iif(lag(end_time,1) over(order by charger_id, start_time asc) < start_time, 1, 0) as unoParo from (select *, strftime('%Y-%m',start_time) as month from sessions
order by charger_id, start_time asc);*/


-- Respuesta teniendo en cuenta que la información solicitada se refiere a cuanto tiempo pasa de media entre que un usuario solicita hacer una carga y el siguiente solicita una carga
-- tomamos esto porque aparentemente hay cargadores que tienen más de 2 puntos de acceso.
select charger_id, month, round(avg(iif(difAnt>0, difAnt , null)),2) as average from
(select charger_id, id, user_id, start_time, month, round(((julianday(start_time) - julianday(lag(start_time,1) over(order by charger_id, start_time))))* 24 * 60,1) as difAnt from
(select *, strftime('%Y-%m',start_time) as month from sessions
order by charger_id, start_time asc))
group by charger_id, month;
