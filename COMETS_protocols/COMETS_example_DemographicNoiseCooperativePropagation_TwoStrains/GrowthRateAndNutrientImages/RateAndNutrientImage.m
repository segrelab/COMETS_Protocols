clear all

azymuth=0;
elevation=90;
width=0.3;
hight=1.0;
xpos=0.0;
ypos=0.33;
edgepos=0.02;

for i=1:400
        for j=1:400
            fluxes{2000}{i}{j}{1}=zeros(13);
        end
end

flux_atTime2000;
full(fluxes);

media_glucose_atTime2000;

time=2000      

fig1=figure()
%set(gcf, 'Position', [100, 100, 1000, 500])
zz(1:400,1:400)=0;
for i=1:400
    for j=1:400
        a=fluxes{time}{i}{j}{1}(13); 
        zz(j,i)=a;
    end
end
s1=pcolor(zz);
axis square
s1.EdgeColor = 'none';
ax=gca;
ax.Box = 'off';
ax.XGrid = 'off';
ax.YGrid = 'off';
ax.ZGrid = 'off';
ax.XTick = [];
ax.YTick = [];
ax.ZTick = [];
ax.ZColor = 'none';
ax.YColor = 'none';
ax.XColor = 'none';
colormap(ax,bone);
view(azymuth,elevation);


fig2=figure()

time_string=num2str(time);
zz(1:400,1:400)=0;
varname=genvarname(['media_' time_string]);
variable=eval(varname);
for i=1:400
    for j=1:400
        zz(j,i)=variable{9}(i,j);
    end
end
s=pcolor(zz);
axis square
s.EdgeColor = 'none';
ax=gca;
ax.Box = 'off';
ax.XGrid = 'off';
ax.YGrid = 'off';
ax.ZGrid = 'off';
ax.XTick = [];
ax.YTick = [];
ax.ZTick = [];
ax.ZColor = 'none';
ax.YColor = 'none';
ax.XColor = 'none';
colormap(ax,copper);
view(azymuth,elevation);
    

    
    
