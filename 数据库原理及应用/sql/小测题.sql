/*ѧ�ţ�        ������        */
/*1.���Լ�����Ϣ���뵽ѧ����*/
insert into Student values('210111316', '�췽尾�', '��', 25, 'CS')


/*2.��ѯû�б�ѧ��ѡ�޵Ŀγ�����*/
select cname from Course
where not exists (select cno from SC where SC.cno = Course.cno)


/*3.��ѯû��ѡ�ε�ѧ������*/
select sname from Student
where not exists(select sno from SC where SC.sno = Student.sno)


/*4.��ѯ��ѡ1�ſγ̵�ѧ������*/
select Student.sname from Student,SC
where not exists (select cno from SC where SC.cno = 1 and SC.sno = Student.sno)
group by sname

/*5.��ѯ����ѡ��20220406ѧ����ѧ�γ̵�ѧ��ѧ�š�*/
select sno from Student where 
exists(select cno from SC where sno = 20220406)

/*6.��ѯ�ɼ��������ѧ��������*/
select Sname from Student,SC where Grade < 60 and Student.Sno = SC.Sno
group by Sname

/*7.��ѯ���������γ̲������ѧ��ѧ�š�*/
select sno from SC
where (select Count(sno) from SC where grade<60) >=2
group by sno

/*8.��ÿ��ͬѧ��ƽ���ɼ���*/
select sname,AVG(Grade) from Student,SC
where Student.sno= SC.sno
group by Student.sname

/*9.��ѯѧ�ִﵽ12�ֵ�ѧ������*/


/*10.��ѯѡ������ѧ��������*/


/*11.���ݿγ̽�ѧ���ɼ�������*/


/*12.��CSϵȫ��ѧ���ĳɼ�����20��,������100����100�ּ�*/
update SC set grade = case when Grade<80 then grade+20 else 100 end
from SC,Student
where Student.sdept = 'CS'

/*13.��ѧ�����ϴ���һ����ͼ����ͼ�����������Լ�����*/
create view IS_Student
as select * from Student