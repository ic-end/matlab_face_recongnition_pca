%2013 9 1 by lichao
%����PCA������ʶ��
clc
clear all
close all

addpath('./����')
addpath('./ѵ��')
N=5;%5����
M=10;%ÿ����5��ͼ

load A A
load meanx
load w

%% ��ѵ����������ƽ�����Ĳ�ֵͶӰ�������ռ�
omiga=w'*A;

%% ������ֵtau
tau=0;
for i=1:size(omiga,2)
    for j=1:size(omiga,2)
        theta=sqrt(sum((omiga(:,i)-omiga(:,j)).^2))/2;
        if theta>tau
            tau=theta;
        end
    end
end
tau;

%% ʶ��
for i=1:N
    for j=6:M-1
        if j<10
            image=double(rgb2gray(imread(['orl_00',num2str(i),'_00',num2str(j),'.bmp'])));
        else
            image=double(rgb2gray(imread(['orl_00',num2str(i),'_0',num2str(j),'.bmp'])));
        end

        x=reshape(image,size(image,1)*size(image,2),1);%��������
        omigax=w'*(x-meanx);
        for k=1:size(omiga,2)
            sigma=sqrt(sum((omigax-omiga(:,k)).^2));
            if sigma<=tau
                ix=fix((k-0.5)/5);
                iy=k-ix*5;
                y=double(rgb2gray(imread(['orl_00',num2str(ix+1),'_00',num2str(iy),'.bmp'])));
                figure
                subplot(1,2,1);imshow(image,[])
                subplot(1,2,2);imshow(y,[])
                
            end
        end
    end
end