/*ѧ�ţ�210111316  �������췽尾� */
/*�߲������Vegetables)
	Vno(�߲˱��)�������ַ��ͣ�8λ��������
	Vname(�߲��������ɱ䳤�ַ��ͣ�20λ�����ǿգ�Ψһ
	Vseason(�߲˼���): �����ַ��ͣ�4���ַ��������
	Vprice(�߲�����): ����С����С�������2λ��С����ǰ6λ����������Ϊ��
	Vpurchaseprice(�߲˽��ۣ�������С����С�������2λ��С����ǰ6λ����������Ϊ��
�̼ұ�(Business)
	Bno(�̼ұ�ţ��������ַ��ͣ�8λ��������
	Bname(�̼��������ɱ䳤�ַ��ͣ�20λ�����ǿ�
	Baddress���̼ҵ�ַ�����ɱ䳤�ַ��ͣ�40λ���������
	Bphone���̼ҵ绰���������ַ��ͣ�11���ַ��������
�̼��߲˱�(BVB)
	Bno(�̼ұ�ţ��������ַ��ͣ�8λ�������룬����Business��Bno
	Vno(�߲˱��)�������ַ��ͣ�8λ�������룬����Fruit��Fno
	Vquantity(�߲˽�������)�����ͣ�Ĭ��ֵΪ200��Ҫ���ڵ���100*/
	create database middleTest
	use middleTest
/*��1����SQL���������������߲˱��̼ұ���̼��߲˱�*/
	create table Vegetables(
	Vno char(8) primary key,
	Vname varchar(20) not null unique,
	Vseason char(4),
	Vprice decimal(6,2) not null,
	Vpurchaseprice decimal(6,2) not null
	)

	create table Business(
	Bno char(8) primary key,
	Bname varchar(20) not null,
	Baddress varchar(40),
	Bphone char(11))

	create table BVB(
	Bno char(8),
	Vno char(8),
	Vquantity int default(200) check (Vquantity >=100),
	foreign key (Bno) references Business(Bno),
	foreign key (Vno) references Vegetables(Vno))
	
/*��2����Vegetables�������һ���µ��߲ˣ�����BVB��������һ�����ݡ�*/
insert into Vegetables
values('v8', '���ٲ�', '�ļ�', 3, 1)

insert into BVB
values('b1','v8',200)
/*��3����ѯb2�̼ҹ�����߲���Ϣ���߲˱�š��߲������߲˼��ڡ��߲����ۡ��߲˽��ۡ��߲˽���������*/
select BVB.Vno,Vname,Vseason,Vprice,Vpurchaseprice,Vquantity from Vegetables,BVB where Bno = 'B2'
/*��4����ѯBVB�ϳ��������������߲���Ϣ���߲˱�š��߲������߲˼��ڡ��߲����ۡ��߲˽��ۡ��߲��ܽ���������*/
select BVB.Vno,Vname,Vseason,Vprice,Vpurchaseprice,Vquantity from Vegetables,BVB where Vquantity =( select Max(Vquantity) from BVB) 
/*��5����ѯ���ٹ���b3�̼�ȫ��������̼���Ϣ(�̼ұ�š��̼������̼ҵ�ַ���̼ҵ绰��*/
select Business.Bno,Bname,Baddress,Bphone from Business,BVB where exists (select Bno from BVB where Bno = 'B3') group by Business.Bno,Bname,Baddress,Bphone
/*��6����ѯ���۲�����v2�߲˵��߲���Ϣ�Լ���������߲˵��̼���Ϣ(�߲������߲����ۡ��̼ұ�š��̼������̼ҵ�ַ���̼ҵ绰��*/
select Vname,Vprice,Bno,Bname,Baddress,Bphone from Vegetables,Business where Vprice <= (select Vprice from Vegetables where Vno = 'v2')
/*��7����ѯû���̼ҽ������߲���Ϣ����Ϣ���߲˱�š��߲������߲˼��ڡ��߲����ۡ��߲˽��ۣ�*/
select BVB.Vno,Vname,Vseason,Vprice,Vpurchaseprice from Vegetables,BVB where not exists(select Bno from BVB,Vegetables where BVB.Vno = Vegetables.Vno)
/*��8������һ����ͼVBV�������������Bno��Bname��Vno��Vname��Vquantity��Vprice��*/
create view VBV as (select BVB.Bno,Bname,BVB.Vno,Vname,Vquantity,Vprice from Vegetables,Business,BVB where BVB.Bno = Business.Bno and BVB.Vno = Vegetables.Vno )

/*��9�������û�U1��U2����Business�Ĳ鿴Ȩ�޸�U1��U1�ٰ�Business��Bname��Baddress�Ĳ鿴Ȩ�޸�U2 */
exec sp_addLogin 'user1'
exec sp_addLogin 'user2'
create user U1 for login user1
create user U2 for login user2

grant select on Business to U1 with grant option
grant select(Bname,Baddress) on Business to U2
/*��10������һ����������ɾ��Vegetables���߲˵�ʱ��ͬʱɾ��BVB�ϵ��̼ҹ����߲˵���Ϣ��*/
create trigger tr_deleteVegetables
on Vegetables
for delete
as
	declare @Vno char(8)
	select @Vno = Vno from deleted
	delete from BVB where Vno = @vno