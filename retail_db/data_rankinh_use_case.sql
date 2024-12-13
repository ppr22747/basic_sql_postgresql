create table student_scores (
	student_id int primary key,
	student_score int
);

insert into student_scores values
(1, 980),
(2, 960),
(3, 960),
(4, 990),
(5, 920),
(6, 960),
(7, 980),
(8, 960),
(9, 940),
(10, 940);

select * from student_scores
order by student_score desc;

select student_id,
	student_score,
	rank() over(order by student_score desc) as student_rank,
	dense_rank() over(order by student_score desc) as student_drank
from student_scores
order by student_score  desc;