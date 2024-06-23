# 1. Creating the Test Suite
Run the following command to create the test suite based on your json file:
```bash
echo "<json file name>" | python generate_suite.py
```
For example, running:
```bash
echo "enroll" | python generate_suite.py
```
Would create a test_suite folder enroll_suite based on enroll.json.

# 2. Running the Test Suite
Run the following command to run the test suite:
```bash
./run_suite.sh <script> <dir>
```
For example, running:
```bash
./run_suite.sh enroll enroll_suite/
```
Would create run your test suite created in step 1.


### A note on the json file format
The JSON file is an array of objects, with each object representing a test case.

One test case would look like the following:
```json
    {
        "Name": "NoTimeConflict",
        "UsingBase": true,
        "Additional": [
            "insert into professor values (2, 'Dr. John', 'DC4556', 'CS')",
            "insert into officehour values ('CS348', 'F2018', 1, 'Wednesday', '10:00')"
        ],
        "Args": [
            "2 O Wednesday 10:00 CS348"
        ],
        "Expected": [
            "OK"
        ]

    }
```
UsingBase is set to true when you want the test sql file to contain SetBase.sql (which creates a minimal database) at the top of TestNoTimeConflict.sql.
For each argument in the Additional array, we then append that to TestNoTimeConflict.sql. 

Hence, our TestNoTimeConflict.sql will look as follows:
```sql
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
insert into professor values (2, 'Dr. John', 'DC4556', 'CS')
insert into officehour values ('CS348', 'F2018', 1, 'Wednesday', '10:00')
```
Where the last 2 lines were added by Additional, and the rest were already in SetBase.sql.
