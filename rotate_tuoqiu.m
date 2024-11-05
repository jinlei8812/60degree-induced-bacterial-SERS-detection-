function tuoqiu(location,radius,tou)
[xx,yy,zz]=sphere(30);%30是画出来的球面的经纬分面数...30的话就是30个经度, 30个纬度
xx=location(:,1)+radius(:,1)*xx;           % 圆心:(4,2,0)   半径:7
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
alpha(tou)         %设置透明度
shading flat       %
colormap white
grid on
for i=1:90
view(360/90*i,15);
 frame(i)=getframe(gcf);
 pause(0.1);
 text(-2.5,-2.5,2,'\downarrow层析','color','c','fontsize',12,'fontweight','bold')
     text(2.5,2.5,7,'\downarrow提取','color','g','fontsize',12,'fontweight','bold');
          text(7.5,9,13.5,'\downarrow浓缩','color','b','fontsize',12,'fontweight','bold');
            text(12.5,-1.5,6,'\downarrow制剂','color',[1 0.5 0],'fontsize',12,'fontweight','bold');
             text(11,-7.5,1.5,'\downarrow醇沉','color','y','fontsize',12,'fontweight','bold');
end
 writegif('不同工段坐标.gif',frame,1);
view(3);
