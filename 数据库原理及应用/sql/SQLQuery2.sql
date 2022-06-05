create database SPJ
use SPJ

create table S(
SNO varchar(10),
SNAME varchar(10),
SSTATUS int,
CITY varchar(10),
primary key (SNO))

create table P(
PNO varchar(10),
PNAME varchar(10),
COLOR varchar(10),
PWEIGHT int,
primary key (PNO))

create table J(
JNO varchar(10),
JNAME varchar(10),
CITY varchar(10),
primary key (JNO))

create table SPJ(
SNO varchar(10),
PNO varchar(10),
JNO varchar(10),
QTY int,
primary key (SNO,PNO,JNO),
foreign key (SNO) references S(SNO),
foreign key (PNO) references P(PNO),
foreign key (JNO) references j(JNO)
);

INSERT INTO S VALUES('S1','����',20,'���')
INSERT INTO S VALUES('S2','ʢ��',10,'����')
INSERT INTO S VALUES('S3','������',30,'����')
INSERT INTO S VALUES('S4','��̫ʢ',20,'���')
INSERT INTO S VALUES('S5','Ϊ��',30,'�Ϻ�')

INSERT INTO P VALUES('P1','��ĸ','��',12)
INSERT INTO P VALUES('P2','��˨','��',17)
INSERT INTO P VALUES('P3','��˿��','��',14)
INSERT INTO P VALUES('P4','��˿��','��',12)
INSERT INTO P VALUES('P5','͹��','��',40)
INSERT INTO P VALUES('P6','����','��',30)

INSERT INTO J VALUES('J1','����','����')
INSERT INTO J VALUES('J2','һ��','����')
INSERT INTO J VALUES('J3','���ɳ�','���')
INSERT INTO J VALUES('J4','�촬��','���')
INSERT INTO J VALUES('J5','������','��ɽ')
INSERT INTO J VALUES('J6','���ߵ糧','����')
INSERT INTO J VALUES('J7','�뵼�峧','�Ͼ�')

INSERT INTO SPJ VALUES('S1','P1','J1',200)	
INSERT INTO SPJ VALUES('S1','P1','J3',100)	
INSERT INTO SPJ VALUES('S1','P1','J4',700)	
INSERT INTO SPJ VALUES('S1','P2','J2',100)	
INSERT INTO SPJ VALUES('S2','P3','J1',400)	
INSERT INTO SPJ VALUES('S2','P3','J2',200)	

INSERT INTO SPJ VALUES('S2','P3','J4',500)	
INSERT INTO SPJ VALUES('S2','P3','J5',400)	
INSERT INTO SPJ VALUES('S2','P5','J1',400)	
INSERT INTO SPJ VALUES('S2','P5','J2',100)	
INSERT INTO SPJ VALUES('S3','P1','J1',200)	
INSERT INTO SPJ VALUES('S3','P3','J1',200)	

INSERT INTO SPJ VALUES('S4','P5','J1',100)	
INSERT INTO SPJ VALUES('S4','P6','J3',300)	
INSERT INTO SPJ VALUES('S4','P6','J4',200)	

INSERT INTO SPJ VALUES('S5','P2','J4',100)	
INSERT INTO SPJ VALUES('S5','P3','J1',200)	
INSERT INTO SPJ VALUES('S5','P6','J2',200)
INSERT INTO SPJ VALUES('S5','P6','J4',500)


select Sno
from SPJ
where JNO = 'J1'

select Sno
from SPJ
where JNO = 'J1' and PNO = 'P1'

SELECT DISTINCT SNO
FROM   SPJ
WHERE  JNO = 'J1' AND PNO IN
						 ( SELECT PNO
						   FROM   P
						   WHERE  COLOR = '��');

SELECT JNO
FROM   J
WHERE  NOT EXISTS
     ( SELECT *
	   FROM   S,P,SPJ
	   WHERE SPJ.JNO = J.JNO
	     and SPJ.SNO = S.SNO
	     and SPJ.PNO = P.PNO
	     and S.CITY  = '���'
	     and P.COLOR = '��');

select distinct PNO
from SPJ
where SNO = 'S1'
select JNO
from SPJ
where PNO = 'P1' and JNO in(
select JNO 
from SPJ
where PNO = 'P2' and SNO = 'S1');

create view ���� 
as 
select SPJ.SNO,Sname,SPJ.PNO,Pname,SPJ.JNO,JName,QTY from S,P,J,SPJ where S.SNO = SPJ.SNO and P.PNO = SPJ.PNO and J.JNO = SPJ.JNO

select Jname from ���� where PNO = 'P1'

update ���� set QTY = QTY + 100 where PNO = 'P1' 

insert into ���� (SPJ.SNO,SPJ.PNO,SPJ.JNO) values ('S1','P1','J2')