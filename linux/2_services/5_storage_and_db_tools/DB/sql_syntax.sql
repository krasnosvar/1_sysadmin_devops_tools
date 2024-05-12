/*
ТИПЫ ДАННЫХ
Числовые типы данных
integer — целочисленный тип, аналогичный типу int в Python. В SQL диапазон целых чисел от -2147483648 до 2147483647.
real — число с плавающей точкой, как float в Python. Точность числа типа real до 6 десятичных разрядов.
Строковые типы данных
'Практикум' — значение строкового типа, в SQL запросе его заключают в одинарные кавычки.
varchar(n) — строка переменной длины, где n — ограничение. Этот тип данных похож на string в Python, но в отличие от него ограничен по длине: в поле можно занести любую строку короче, чем n символов.
text — строка любой длины. Полный аналог string в Python.
Дата и время
Любые вводимые значения даты или времени заключают в одинарные кавычки.
timestamp — дата и время. В формате timestamp чаще всего хранят события, происходящие несколько раз за день. Например, логи пользователей сайта.
date — дата.
Логический
boolean — логический тип данных. В SQL есть три варианта значений TRUE — «истина», FALSE — «ложь» и NULL — «неизвестно».


Напишите запрос, который найдёт средний вес (weight) товаров из таблицы products_data_all в граммах (где units='г'). 
Назовите переменную average. Измените тип данных в столбце weight на число с плавающей точкой.
ответом будет одно число
*/
SELECT 
	AVG (CAST(weight AS real)) AS average
FROM
	products_data_all
WHERE units='г';
/*
Напишите запрос, который найдёт максимальный вес продукта в категории 'молоко и сливки'. 
Воспользуйтесь конструкцией CAST AS для приведения значений к числу с плавающей точкой и назовите переменную max_weight.
*/
SELECT 
	MAX (CAST(weight AS real)) AS max_weight
FROM
	products_data_all
WHERE
    category = 'молоко и сливки';
