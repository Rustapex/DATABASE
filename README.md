# Oracle SQL 실습 모음

> Oracle DB를 기준으로 SQL 기본 문법, 페이징, 시퀀스, 계층 쿼리, 인덱스, 프로시저, 함수, 트리거를 실습한 데이터베이스 학습 저장소입니다.

<br>

## 목차

1. [프로젝트 소개](#1-프로젝트-소개)
2. [주요 실습 내용](#2-주요-실습-내용)
3. [기술 스택](#3-기술-스택)
4. [프로젝트 구조](#4-프로젝트-구조)
5. [실행 방법](#5-실행-방법)
6. [구현 및 학습 포인트](#6-구현-및-학습-포인트)
7. [테스트 및 검증](#7-테스트-및-검증)
8. [개선 예정 사항](#8-개선-예정-사항)
9. [참고 사항](#9-참고-사항)

<br>

## 1. 프로젝트 소개

이 저장소는 Oracle DB를 기준으로 SQL과 PL/SQL을 실습한 데이터베이스 학습 저장소입니다.

기본 SELECT 문부터 JOIN, 서브쿼리, 페이징, 시퀀스, 계층 쿼리, 인덱스, 프로시저, 함수, 트리거 등 Oracle 환경에서 사용하는 주요 SQL 문법과 DB 객체를 실습했습니다.

특정 서비스의 데이터베이스 설계 결과물이 아니라, Oracle SQL 문법과 데이터베이스 기능을 이해하기 위한 실습 모음입니다.

주요 목표는 다음과 같습니다.

* Oracle SQL 기본 문법 학습
* 테이블 생성과 데이터 조작 실습
* 페이징, 계층 쿼리, 인덱스 등 Oracle 주요 기능 확인
* PL/SQL 기반 프로시저, 함수, 트리거 작성 실습
* 웹 프로젝트에서 DB를 다루기 위한 SQL 기반 학습

<br>

## 2. 주요 실습 내용

### SQL 기본 문법

* SELECT 조회
* WHERE 조건 검색
* INSERT
* UPDATE
* DELETE
* COMMIT / ROLLBACK
* 테이블 생성 및 삭제

### Oracle SQL 실습

* `ROWNUM` 기반 페이징
* `FETCH FIRST` 문법
* 서브쿼리 기반 페이지 조회
* `SEQUENCE` 생성 및 사용
* JOIN
* 계층 쿼리
* `START WITH`
* `CONNECT BY PRIOR`
* `ORDER SIBLINGS BY`

### 인덱스 실습

* 인덱스 생성
* 인덱스 조회
* 인덱스 삭제
* 인덱스 사용 시 고려할 점 확인

### PL/SQL 실습

* PROCEDURE 작성 및 실행
* FUNCTION 작성 및 실행
* TRIGGER 작성 및 동작 확인
* `IN`, `OUT` 파라미터 실습
* `%TYPE`, `%ROWTYPE` 사용
* `DBMS_OUTPUT` 출력 확인

<br>

## 3. 기술 스택

| 구분 | 기술 |
|---|---|
| Database | Oracle DB |
| Language | SQL, PL/SQL |
| Tool | SQL Developer / DBeaver 등 SQL 실행 도구 |
| Concept | Sequence, Index, Procedure, Function, Trigger |
| Project Type | Database Practice |

<br>

## 4. 프로젝트 구조

이 저장소는 Oracle SQL 실습 파일을 모아둔 구조입니다.

```text
DATABASE/
├── *.sql
└── README.md
```

### 주요 파일 설명

| 구분 | 설명 |
|---|---|
| SQL 실습 파일 | Oracle SQL 문법과 DB 객체 실습 쿼리 |
| 테이블 생성 스크립트 | 실습용 테이블 생성 및 샘플 데이터 입력 |
| 조회 쿼리 | SELECT, JOIN, 서브쿼리, 페이징 등 조회 실습 |
| PL/SQL 예제 | 프로시저, 함수, 트리거 실습 |

<br>

## 5. 실행 방법

이 저장소는 Oracle DB 기준 SQL 실습 파일을 모아둔 저장소입니다.  
Oracle DB에 접속한 뒤, 필요한 테이블 생성 SQL을 먼저 실행하고 각 실습 SQL 파일을 순서대로 실행하여 결과를 확인합니다.

### 5-1. 저장소 클론

```bash
git clone https://github.com/Rustapex/DATABASE.git
cd DATABASE
```

### 5-2. Oracle DB 접속

SQL Developer, DBeaver 등 Oracle DB 접속이 가능한 도구를 사용합니다.

```text
Host: localhost
Port: 1521
Service Name 또는 SID: 환경에 맞게 설정
Username: 사용자 계정
Password: 사용자 비밀번호
```

> 실제 DB 계정과 비밀번호는 README에 작성하지 않습니다.

### 5-3. SQL 파일 실행

1. 테이블 생성 SQL 실행
2. 샘플 데이터 INSERT 실행
3. SELECT / JOIN / 페이징 쿼리 실행
4. 프로시저, 함수, 트리거 등 PL/SQL 객체 생성
5. 실행 결과 확인

<br>

## 6. 구현 및 학습 포인트

### 6-1. Oracle 기준 페이징 쿼리

* `FETCH FIRST`, `ROWNUM`, 서브쿼리를 사용하여 Oracle에서 페이징을 처리하는 방식을 실습했습니다.
* 단순 조회와 페이지 단위 조회의 차이를 확인했습니다.
* 이후 웹 프로젝트에서 목록 조회와 페이징을 구현할 때 필요한 SQL 기반을 다졌습니다.

### 6-2. 시퀀스와 인덱스

* Oracle의 `SEQUENCE`를 사용하여 식별자 값을 생성하는 흐름을 실습했습니다.
* `INDEX` 생성, 조회, 삭제를 통해 조회 성능과 인덱스 관리 개념을 확인했습니다.
* 인덱스가 항상 좋은 것이 아니라 데이터 변경이 많은 경우 비용이 발생할 수 있다는 점을 실습을 통해 확인했습니다.

### 6-3. 계층 쿼리

* `START WITH`, `CONNECT BY PRIOR`를 사용하여 계층형 데이터를 조회하는 방식을 실습했습니다.
* 조직도나 댓글 구조처럼 부모-자식 관계를 가진 데이터를 조회하는 흐름을 확인했습니다.
* `ORDER SIBLINGS BY`를 통해 같은 계층 안에서 정렬하는 방식도 함께 실습했습니다.

### 6-4. PL/SQL 기초

* `PROCEDURE`, `FUNCTION`, `TRIGGER`를 작성하여 DB 내부에서 로직을 실행하는 방법을 실습했습니다.
* `IN`, `OUT` 파라미터, `%TYPE`, `%ROWTYPE`, `DBMS_OUTPUT` 등을 사용했습니다.
* 애플리케이션 코드 외에도 DB 내부에서 처리할 수 있는 로직 구조를 학습했습니다.

<br>

## 7. 테스트 및 검증

이 저장소는 별도의 테스트 프레임워크가 아니라 SQL 실행 결과를 통해 실습 내용을 검증했습니다.

### 주요 검증 범위

* 테이블 생성 여부 확인
* INSERT 후 데이터 조회 확인
* SELECT / JOIN / 서브쿼리 결과 확인
* 페이징 쿼리 결과 범위 확인
* 시퀀스 값 증가 확인
* 인덱스 생성 및 삭제 확인
* 프로시저, 함수, 트리거 실행 결과 확인

<br>

## 8. 개선 예정 사항

현재 저장소를 기준으로 앞으로 개선하면 좋은 사항입니다.

* SQL 파일을 주제별로 재분류
* 테이블 생성 → 데이터 입력 → 조회 → PL/SQL 객체 생성 순서로 실행 흐름 정리
* 실습용 테이블과 임시 테이블 구분
* Oracle 전용 문법임을 README에 명확히 표시
* 각 SQL 파일 상단에 실습 목적 주석 추가

<br>

## 9. 참고 사항

### 프로젝트 형태

* 프로젝트 형태: 개인 학습 / Oracle SQL 수업 실습 모음
* 실행 기준: Oracle DB
* 저장소 성격: SQLD 정리 문서가 아닌 Oracle SQL 및 PL/SQL 실습 기록

### 참고

* 이 저장소는 Oracle DB 기준으로 작성된 SQL 실습 파일을 포함합니다.
* 다른 DBMS에서는 일부 문법이 다르게 동작할 수 있습니다.
* 실제 DB 계정, 비밀번호, 접속 정보 등 민감 정보는 README에 포함하지 않습니다.
