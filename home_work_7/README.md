# DML: агрегация и сортировка, CTE, аналитические функции

1) Написать запрос суммы очков с группировкой и сортировкой по годам

        select year_game, sum(points) from statistic group by year_game order by year_game;
    
2) Написать cte показывающее тоже самое
    
        with stat as
        (
            select distinct year_game as year,
            sum(points) over (partition by year_game) as summary
            from statistic
        )
        select year, summary from stat order by year;

3) Используя функцию LAG вывести кол-во очков по всем игрокам за текущий код и за предыдущий
   
       with stat as
       (
           select distinct year_game as year,
           sum(points) over (partition by year_game) as summary
           from statistic
       )
       select year, summary as current, lag(summary) over (order by year) as previous from stat order by year;