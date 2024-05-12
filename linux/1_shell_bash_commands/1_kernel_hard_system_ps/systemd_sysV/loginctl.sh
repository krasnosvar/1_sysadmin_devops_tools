#loginctl: 
#управление сеансами пользователей.
#заблокировать текущую сессию
loginctl lock-session
#вывести список открытых сеансов
loginctl list-sessions
#Получить список залогинившихся пользователей:
loginctl list-users
#уничтожить текущий сеанс, закрыв все приложения и освободив ресурсы
loginctl terminate-session
#Вывести информацию о состоянии текущего сеанса (или любого другого, если добавить id), 
#включая список дочерних процессов и номер виртуальной консоли:
loginctl session-status