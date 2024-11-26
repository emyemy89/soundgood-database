-- (1) Show the number of lessons given per month during a specified year

-- This query is expected to be performed a few times per week. 
-- It shall be possible to retrieve the total number of lessons per month 
-- (just one number per month) and the specific number of individual lessons,
--  group lessons and ensembles (three numbers per month). It's not required 
--  that all four numbers (total plus one per lesson type) for a particular 
--  month are on the same row; you're allowed to have one row for each number 
--  as long as it's clear to which month each number belongs. However, it's 
-- most likely easier to understand the result if you do place all numbers for a 
--  particular month on the same row, and it's an interesting exercise, 
--  therefore you're encouraged to try. Table 1 below is an example result 
--  of such a query, illustrating the expected output



SELECT COUNT(l.*), COUNT (il.*), COUNT(gl.*), COUNT(ensamble.*)
FROM lesson l 
LEFT JOIN individual_lesson il ON l.lesson_id=il.lesson_id
LEFT JOIN group_lesson gl ON l.lesson_id=gl.lesson_id
LEFT JOIN ensamble e ON l.lesson_id=e.lesson_id