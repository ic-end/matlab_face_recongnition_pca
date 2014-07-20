%2013 9 1 by lichao
%����PCA������ʶ��
clc
clear all
close all

addpath('./����')
addpath('./ѵ��')
N=5;%5����
M=5;%ÿ����5��ͼ

for i=1:N
    for j=1:M
        image=double(rgb2gray(imread(['orl_00',num2str(i),'_00',num2str(j),'.bmp'])));
        x(:,(i-1)*N+j)=reshape(image,size(image,1)*size(image,2),1);%��������
    end
end

meanx=1/(N*M)*sum(x,2);%����ƽ����

A=x-repmat(meanx,1,N*M);%�����ֵ������ÿһ����һ����ֵ������

C=1/(N*M)*A'*A;%����Э�������

[U,lamda,V]=svd(C);%������ֵ����������

eigenvalues = sort(diag(lamda),'descend');%����ֵ��������

%ѡȡ���ļ�������ֵ
Tolerance=0.9999;
phi=0;
eigen=0;
eigennum=0;
eigensum=sum(eigenvalues.^2);
while phi<=Tolerance
    eigennum=eigennum+1;
    eigen=eigen+(eigenvalues(eigennum).^2);
    phi=eigen/eigensum;
end

%�ҵ����ļ�������ֵ��Ӧ����������

for i=1:eigennum
    k=find(diag(lamda)==eigenvalues(i));
    w(:,i)=1/eigenvalues(i)*A*V(:,k);
end


save A A
save meanx meanx
save w w



