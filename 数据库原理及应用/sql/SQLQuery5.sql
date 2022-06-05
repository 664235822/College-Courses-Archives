create table Student(
	Sno varchar(10) primary key,
	Sname varchar(10) not null,
	Sage datetime,
	Ssex varchar(10)
	);
insert into Student values(01 , '����' , 1990-01-01 , '��');
insert into Student values(02 , 'Ǯ��' , 1990-12-21 , '��');
insert into Student values(03 , '���' , 1990-12-20 , '��');
insert into Student values(04 , '����' , 1990-12-06 , '��');
insert into Student values(05 , '��÷' , 1991-12-01 , 'Ů');
insert into Student values(06 , '����' , 1992-01-01 , 'Ů');
insert into Student values(07 , '֣��' , 1989-01-01 , 'Ů');
insert into Student values(09 , '����' , 2017-12-20 , 'Ů');
insert into Student values(10 , '����' , 2017-12-25 , 'Ů');
insert into Student values(11 , '����' , 2012-06-06 , 'Ů');
insert into Student values(12 , '����' , 2013-06-13 , 'Ů');
insert into Student values(13 , '����' , 2014-06-01 , 'Ů');

create table Teacher(
	Tno varchar(10) primary key,
	Tname varchar(10) not null
	);
insert into Teacher values('01' , '����');
insert into Teacher values('02' , '����');
insert into Teacher values('03' , '����');

create table Course(
	Cno varchar(10) primary key,
	Cname nvarchar(10) not null,
	Tno varchar(10),
	foreign key(Tno) references Teacher(Tno)
	);
insert into Course values('01' , '����' , '02');
insert into Course values('02' , '��ѧ' , '01');
insert into Course values('03' , 'Ӣ��' , '03');

create table SC(
	Sno varchar(10),
	Cno varchar(10),
	score decimal(18,1)
	primary key(Sno, Cno),
	foreign key(Sno) references Student(Sno),
	foreign key(Cno) references Course(Cno)
	);
insert into SC values('01' , '01' , 80);
insert into SC values('01' , '02' , 90);
insert into SC values('01' , '03' , 99);
insert into SC values('02' , '01' , 70);
insert into SC values('02' , '02' , 60);
insert into SC values('02' , '03' , 80);
insert into SC values('03' , '01' , 80);
insert into SC values('03' , '02' , 80);
insert into SC values('03' , '03' , 80);
insert into SC values('04' , '01' , 50);
insert into SC values('04' , '02' , 30);
insert into SC values('04' , '03' , 20);
insert into SC values('05' , '01' , 76);
insert into SC values('05' , '02' , 87);
insert into SC values('06' , '01' , 31);
insert into SC values('06' , '03' , 34);
insert into SC values('07' , '02' , 89);
insert into SC values('07' , '03' , 98);

create trigger trigger_insertStudent
on Student
for insert
as 
	declare @sno varchar(10),@cno varchar(10)
	select @sno = sno from inserted
	select top 1 @cno=cno from Course order by rand()
	insert into SC values(@sno,@cno,60)
	
create trigger trigger_updateGrade
on SC
for insert,update
as 
	declare @sno varchar(10), @score decimal(18,1)
	select @sno = sno,@score = score from inserted
	declare @sname varchar(10)
	select @sname = sname from Student where sno = @sno
	if(@score < 60)
		begin
			print '���ѧ��Ϊ'+ @sno+'������Ϊ'+@sname+'��ͬѧ�����ޱ�'
		end

create trigger trigger_deleteStudent
on Student
for delete
as
	declare @sno varchar(10)
	select @sno = sno from deleted
	delete from SC where sno = @sno