CREATE TABLE Hotel (
    hotel_id     VARCHAR2(5)
        CONSTRAINT pk_hotel PRIMARY KEY
        CONSTRAINT ck_hotel_id CHECK (hotel_id LIKE 'h%'),
    hotel_name   VARCHAR2(20)
        CONSTRAINT nn_hotel_name NOT NULL,
    hotel_star   NUMBER(1)
        CONSTRAINT nn_hotel_star NOT NULL
        CONSTRAINT ck_hotel_star CHECK (hotel_star BETWEEN 1 AND 5)
);
select * from hotel;

desc customer;
CREATE TABLE Hotel_Customer (
    customer_id  VARCHAR2(10)
        CONSTRAINT pk_hotel_customer PRIMARY KEY
        CONSTRAINT ck_hotel_customer_id CHECK (customer_id LIKE 'c%'),
    name         VARCHAR2(50)
        CONSTRAINT nn_hotel_customer_name NOT NULL,
    tel          VARCHAR2(20)
        CONSTRAINT uk_hotel_customer_tel UNIQUE
);

select * from hotel_customer;

CREATE TABLE RoomGrade (
    roomgrade_num   VARCHAR2(5)
        CONSTRAINT pk_roomgrade PRIMARY KEY
        CONSTRAINT ck_roomgrade_num CHECK (roomgrade_num LIKE 'rg%'),
    room_name       VARCHAR2(20)
        CONSTRAINT nn_roomgrade_room_name NOT NULL,
    price           NUMBER(10)
        CONSTRAINT nn_roomgrade_price NOT NULL
        CONSTRAINT ck_roomgrade_price CHECK (price > 0),
    hotel_id        VARCHAR2(5)
        CONSTRAINT nn_roomgrade_hotel_id NOT NULL,
    CONSTRAINT fk_roomgrade_hotel
        FOREIGN KEY (hotel_id) REFERENCES Hotel(hotel_id)
);

CREATE TABLE Reservation (
    reservation_id    VARCHAR2(10)
        CONSTRAINT pk_reservation PRIMARY KEY
        CONSTRAINT ck_reservation_id CHECK (reservation_id LIKE 'r%'),
    customer_id       VARCHAR2(10)
        CONSTRAINT nn_reservation_customer_id NOT NULL,
    reservation_date  DATE
        CONSTRAINT nn_reservation_date NOT NULL,
    reservation_num   NUMBER(2)
        CONSTRAINT nn_reservation_num NOT NULL
        CONSTRAINT ck_reservation_num CHECK (reservation_num >= 1),
    check_in          DATE
        CONSTRAINT nn_reservation_check_in NOT NULL,
    check_out         DATE
        CONSTRAINT nn_reservation_check_out NOT NULL,
    breakfast         CHAR(1)
        CONSTRAINT ck_reservation_breakfast CHECK (breakfast IN ('Y', 'N')),
    roomgrade_num     VARCHAR2(5)
        CONSTRAINT nn_reservation_roomgrade_num NOT NULL,
    CONSTRAINT fk_reservation_customer
        FOREIGN KEY (customer_id) REFERENCES Hotel_Customer(customer_id),
    CONSTRAINT fk_reservation_roomgrade
        FOREIGN KEY (roomgrade_num) REFERENCES RoomGrade(roomgrade_num),
    CONSTRAINT ck_reservation_stay_date
        CHECK (check_out > check_in),
    CONSTRAINT ck_reservation_checkin_date
        CHECK (reservation_date < check_in)
);

INSERT INTO Hotel (hotel_id, hotel_name, hotel_star)
VALUES ('h001', 'SeoulHotel', 5);

INSERT INTO Hotel (hotel_id, hotel_name, hotel_star)
VALUES ('h002', 'BusanStay', 4);


INSERT INTO Hotel_Customer (customer_id, name, tel)
VALUES ('c001', '김민수', '010-1111-1111');

INSERT INTO Hotel_Customer (customer_id, name, tel)
VALUES ('c002', '이서연', '010-2222-2222');


INSERT INTO RoomGrade (roomgrade_num, room_name, price, hotel_id)
VALUES ('rg001', 'Standard', 120000, 'h001');

INSERT INTO RoomGrade (roomgrade_num, room_name, price, hotel_id)
VALUES ('rg002', 'Deluxe', 180000, 'h001');

INSERT INTO RoomGrade (roomgrade_num, room_name, price, hotel_id)
VALUES ('rg003', 'Ocean', 150000, 'h002');


INSERT INTO Reservation
    (reservation_id, customer_id, reservation_date, reservation_num, check_in, check_out, breakfast, roomgrade_num)
VALUES
    ('r001', 'c001', DATE '2026-04-14', 2, DATE '2026-04-20', DATE '2026-04-22', 'Y', 'rg001');

INSERT INTO Reservation
    (reservation_id, customer_id, reservation_date, reservation_num, check_in, check_out, breakfast, roomgrade_num)
VALUES
    ('r002', 'c002', DATE '2026-04-15', 1, DATE '2026-04-18', DATE '2026-04-19', 'N', 'rg002');

INSERT INTO Reservation
    (reservation_id, customer_id, reservation_date, reservation_num, check_in, check_out, breakfast, roomgrade_num)
VALUES
    ('r003', 'c001', DATE '2026-04-16', 3, DATE '2026-04-25', DATE '2026-04-27', 'Y', 'rg003');
COMMIT;

select * from hotel;
select * from hotel_customer;
select * from roomgrade;
select * from reservation;

desc hotel_customer;
desc reservation;

select c.customer_id, c.name,  h.hotel_name, h.hotel_id, h.hotel_star
from hotel_customer c
join reservation r
    on c.customer_id = r.customer_id
join roomgrade g
    on r.roomGrade_num = g.roomGrade_num
join hotel h
    on h.hotel_id= g.hotel_id;
    
select * from roomgrade;
select * from reservation;
select * from hotel;
    
-- 예약자 번호를 통한 방 이름과 그 가격, 조식여부 조회하기
select c.customer_id "예약번호", g.room_Name as "객실구분", 
    decode(r.breakfast , 'Y', '있음', 'N', '없음', '없음') as "조식"
from hotel_customer c
join reservation r
    on c.customer_id = r.customer_id
join roomGrade g
    on r.roomGrade_num = g.roomGrade_num;
    
-- 호텔 이름이 BusanStay인 호텔의 예약사항 조회하기
select h.hotel_name "호텔명", r.reservation_num "예약번호", r.customer_id "고객번호" 
from hotel h
join roomGrade g
    on h.hotel_id = g.hotel_id
join reservation r
    on g.roomgrade_num = r.roomgrade_num
where h.hotel_name = 'BusanStay';