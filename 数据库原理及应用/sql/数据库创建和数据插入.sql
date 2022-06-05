/*����ѧ����*/
create table Student(
	Sno char(9) primary key,
	Sname char(20) Unique,
	Ssex char(2),
	Sage Smallint,
	Sdept char(20)
 )
 /*����ѡ�α�*/
 create table Course(
	Cno char(4) primary key,
	Cname char(40) not null,
	Cpno Char(4),
	Ccredit Smallint,
	foreign key(Cpno) references Course(Cno)
 )
  /*����ѡ�ޱ�*/
  create table SC(
	Sno char(9),
	Cno char(4),
	Grade Smallint,
	primary key(Sno, Cno),
	foreign key(Sno) references Student(Sno),
	foreign key(Cno) references Course(Cno)
  )
 /*��������*/ 
 insert
 into Student
 values('20220401', '��һ', 'Ů', 20, 'CS'),
	   ('20220402', '���', '��', 19, 'CS'),
	   ('20220403', '����', 'Ů', 18, 'IS'),
	   ('20220404', '����', 'Ů', 17, 'IS'),
	   ('20220405', '����', '��', 20, 'MA'),
	   ('20220406', '����', 'Ů', 21, 'MA'),
	   ('20220407', '����', '��', 19, 'CS')

insert 
into Course
values(1,'���ݿ�',5,4),
	(2,'����',4,2),
	(3,'����ϵͳ',8,4),
	(4,'��ѧ',NULL,3),
	(5,'���ݽṹ',7,6),
	(6,'JAVA',NULL,4),
	(7,'C����',4,4),
	(8,'���������',6,6),
	(9,'��������',2,6)

insert 
into SC
values('20220401',1,80),
	('20220401',2,85),
	('20220401',5,88),
	('20220401',6,59),
	('20220401',7,20),
	('20220402',2,30),
	('20220402',6,50),
	('20220402',4,51),
	('20220403',4,90),
	('20220405',1,90),
	('20220405',8,91),
	('20220405',9,70),
	('20220406',8,60),
	('20220406',9,40)

   