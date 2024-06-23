drop table enrollment
drop table officehour
drop table section
drop table course
drop table student
drop table professor

create table professor ( \
   pnum     integer not null, \
   pname    varchar(30) not null, \
   office   char(6) not null, \
   dept     char(2) not null, \
   primary key (pnum))

create table student ( \
   snum      integer not null, \
   sname     varchar(30) not null, \
   year      integer not null,  \
   primary key (snum))

create table course ( \
   cnum      char(5) not null, \
   cname     varchar(50) not null, \
   primary key (cnum))

create table section ( \
   cnum      char(5) not null, \
   term      char(5) not null, \
   section   integer not null, \
   pnum      integer not null, \
   day       char(10) not null, \
   time      time not null, \
   primary key (cnum,term,section), \
   foreign key (cnum) references course(cnum), \
   foreign key (pnum) references professor(pnum))

create table officehour ( \
   cnum      char(5) not null, \
   term      char(5) not null, \
   pnum      integer not null, \
   day       char(10) not null, \
   time      time not null, \
   primary key (cnum,term,pnum,day,time), \
   foreign key (cnum) references course(cnum), \
   foreign key (pnum) references professor(pnum))

create table enrollment ( \
   snum      integer not null, \
   cnum      char(5) not null, \
   term      char(5) not null, \
   section   integer not null, \
   grade     integer, \
   primary key (snum,cnum,term,section), \
   foreign key (snum) references student(snum), \
   foreign key (cnum,term,section) references section(cnum,term,section));

