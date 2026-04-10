CREATE TABLE department (
    dept_id   NUMBER(4),
    dept_name VARCHAR2(30) NOT NULL,
    CONSTRAINT pk_department PRIMARY KEY (dept_id),
    CONSTRAINT uq_department_name UNIQUE (dept_name)
);

CREATE TABLE student (
    student_id NUMBER(8),
    ssn        VARCHAR2(20) NOT NULL,
    email      VARCHAR2(100) NOT NULL,
    name       VARCHAR2(30) NOT NULL,
    dept_id    NUMBER(4),
    CONSTRAINT pk_student PRIMARY KEY (student_id),
    CONSTRAINT uq_student_ssn UNIQUE (ssn),
    CONSTRAINT uq_student_email UNIQUE (email),
    CONSTRAINT fk_student_dept FOREIGN KEY (dept_id)
        REFERENCES department(dept_id)
);

CREATE TABLE course (
    course_id   NUMBER(6),
    course_name VARCHAR2(50) NOT NULL,
    CONSTRAINT pk_course PRIMARY KEY (course_id)
);

CREATE TABLE enrollment (
    student_id NUMBER(8),
    course_id  NUMBER(6),
    enroll_dt  DATE DEFAULT SYSDATE,
    CONSTRAINT pk_enrollment PRIMARY KEY (student_id, course_id),
    CONSTRAINT fk_enrollment_student FOREIGN KEY (student_id)
        REFERENCES student(student_id),
    CONSTRAINT fk_enrollment_course FOREIGN KEY (course_id)
        REFERENCES course(course_id)
);

INSERT INTO department (dept_id, dept_name) VALUES (10, '컴퓨터공학과');
INSERT INTO department (dept_id, dept_name) VALUES (20, '경영학과');

INSERT INTO student (student_id, ssn, email, name, dept_id)
VALUES (20260001, '010101-1234567', 'kim1@example.com', '김민수', 10);

INSERT INTO student (student_id, ssn, email, name, dept_id)
VALUES (20260002, '020202-2345678', 'lee1@example.com', '이서연', 20);

INSERT INTO course (course_id, course_name) VALUES (101001, '데이터베이스');
INSERT INTO course (course_id, course_name) VALUES (101002, '운영체제');

INSERT INTO enrollment (student_id, course_id) VALUES (20260001, 101001);
INSERT INTO enrollment (student_id, course_id) VALUES (20260001, 101002);
commit;