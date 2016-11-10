# FOCS Day 19 Activity 2

Download `courses.csv`  and `instructors.csv` from `https://github.com/focs16fall/focs-assignments/tree/master/day19/`.

Start `sqlite3`, and enter the following commands.

```sql
sqlite> .headers on
sqlite> .mode csv
sqlite> .import courses.csv course
sqlite> .import instructors.csv instructor
sqlite> .mode column
```

Try out some examples:


```sql
select course_title from course;
select area from course;
select distinct area from course;
select count(distinct area) from course;
select course_title, area from course;
select * from course;
select *, sum(credits) from course where area='ENGR';
select *, sum(credits) from course group by area;
select * from course join instructor on course.course_number = instructor.course_number;
select instructor from course join instructor on course.course_number = instructor.course_number where area = 'ENGR'; 
```
a. Set QEA to 16 credits:

`update course set credits=16;`

Test the effect of this command on the database.

b. Count the rows table: `select count(instructor) from instructor`. How many *distinct* instructors are there?

c. Use INSERT to add another course: `INSERT INTO course (course_title, course_number, area, credits) VALUES (value1, value2, value3, value4);`. How do you need to update the instructor table? Test this with a `JOIN`.