-- OUTPUT MODES
-- sqlite> .mode list
-- sqlite> .mode insert
-- sqlite> .mode column
-- sqlite> .mode line
-- sqlite> .mode tabs

-- SELECT - INSERT
.open studennts.db
select * from cources;
insert into cources (id, name, lessons_amount) values (1, 'Базы данных', 12);
insert into cources (name, lessons_amount) values ('Linux. Рабочая станция', 8), ('Основы Python', 8);
