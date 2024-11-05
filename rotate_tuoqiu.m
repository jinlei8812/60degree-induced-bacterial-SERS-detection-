function tuoqiu(location,radius,tou)
[xx,yy,zz]=sphere(30);%30�ǻ�����������ľ�γ������...30�Ļ�����30������, 30��γ��
xx=location(:,1)+radius(:,1)*xx;           % Բ��:(4,2,0)   �뾶:7
yy=location(:,2)+radius(:,2)*yy;
zz=location(:,3)+radius(:,3)*zz;
%figure;
set(gcf,'outerposition',get(0,'screensize'));
set(gcf,'color','w');
mesh(xx,yy,zz,'FaceColor','interp','EdgeColor','w','FaceLighting','phong')
%h = mesh(x_axis,y_axis,z_axis,'FaceColor','interp','Edgecolor',[0.9 0.95 0.9],'FaceLighting','phong');
set(gca,'FontWeight','bold','Color',[0.3 0.3 0.3],'FontSize',14);
xlabel('x')
ylabel('y')
zlabel('z')
axis equal
alpha(tou)         %����͸����
shading flat       %
colormap white
grid on
for i=1:90
view(360/90*i,15);
 frame(i)=getframe(gcf);
 pause(0.1);
 text(-2.5,-2.5,2,'\downarrow����','color','c','fontsize',12,'fontweight','bold')
     text(2.5,2.5,7,'\downarrow��ȡ','color','g','fontsize',12,'fontweight','bold');
          text(7.5,9,13.5,'\downarrowŨ��','color','b','fontsize',12,'fontweight','bold');
            text(12.5,-1.5,6,'\downarrow�Ƽ�','color',[1 0.5 0],'fontsize',12,'fontweight','bold');
             text(11,-7.5,1.5,'\downarrow����','color','y','fontsize',12,'fontweight','bold');
end
 writegif('��ͬ��������.gif',frame,1);
view(3);
