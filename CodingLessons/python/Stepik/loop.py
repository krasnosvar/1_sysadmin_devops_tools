#!/usr/bin/env python3
#ввод данных в одну строку через пробел
a = input().split()
# создаем пустой список
x = []
# создаем цикл с переменной "i" в диапазоне длины введенных чисел
for i in range(0, len(a) - 1):
    # назначаем переменную y, которая указывает на порядковый номер значения в списке
    y = 0 + i
    # начинаем добавлять в список значения, 
    x.append(int(a[i - 1]) + int(a[i + 1]))
x.append(int(a[0]) + int(a[-2]))
print(' '.join([str(i) for i in x]))