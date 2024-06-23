delete from enrollment
delete from officehour
delete from section
delete from course
delete from student
delete from professor

insert into professor values (1, 'Dr Mary', 'DC3346', 'CS')
-- insert into student values (1, 'Mary', 3) (snum, sname, year)
insert into student values (1, 'Mary', 3)

-- insert into course values ('CS348', 'Intro to Databases') (cnum, cname)
insert into course values ('CS348', 'Intro to Databases')

-- insert into section values ('CS348', 'F2018', 1, 1, 'Tuesday', '10:00') (cnum, term, section, pnum, day, time)
insert into section values ('CS348', 'F2018', 1, 1, 'Tuesday', '10:00')

-- insert into enrollment values (1, 'CS348', 'F2018', 1, 88) (snum, cnum, term, section, grade)
insert into enrollment values (1, 'CS348', 'F2018', 1, NULL)

-- insert into officehour values ('CS348', 'S2020', 1, 'Tuesday', '09:00') (cnum, term, pnum, day, time)
