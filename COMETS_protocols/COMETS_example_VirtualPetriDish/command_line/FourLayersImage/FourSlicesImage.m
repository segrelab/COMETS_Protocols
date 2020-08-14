clear all
azymuth=20;
elevation=80;
width=1.0;
hight=0.25;
xpos=0.25;
ypos=0;


fig=figure;
set(gcf, 'Position', [100, 100, 300, 600])

subplot('Position',[ypos xpos*3 width hight])
    
biomass_atStep8000; 

    var=full(biomass_8000_0);
    s=pcolor(1:200,1:200,var)
    hold on
    divide(1:200)=100;
    plot(1:200,divide,'w--');
    s.EdgeColor = 'none';
    ax=gca;
    zlim([0 3]);
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
    clear var
    
    subplot('Position',[ypos xpos*2 width hight])
    
    for i=1:200
        for j=1:200
            fluxes{8000}{i}{j}{1}=[];
            fluxes{8000}{i}{j}{1}(1:95)=0.0;
        end
    end
    zz(1:200,1:200)=0;
    flux_atStep8000;
   
    for i=1:200
        for j=1:200
                zz(j,i)=fluxes{8000}{i}{j}{1}(13);
        end
    end

    s=pcolor(1:200,1:200,zz);
    hold on
    divide(1:200)=100;
    plot(1:200,divide,'w--');
    s.EdgeColor = 'none';
    ax=gca;
    zlim([0 20.0]);
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
    colormap(ax,gray);
    view(azymuth,elevation);
    
    clear fluxes;
    
    subplot('Position',[ypos xpos*1 width hight])
    zz(1:200,1:200)=0;
    media_atStep8000;
    
    for i=1:200
        for j=1:200
                zz(j,i)=media_8000{1}(i,j);
        end
    end

    s=pcolor(1:200,1:200,zz)
    hold on
    divide(1:200)=100;
    plot(1:200,divide,'w--');
    s.EdgeColor = 'none';
    ax=gca;
    zlim([0 1000]);
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
    colormap(ax,jet);
    view(azymuth,elevation);
    
    
    subplot('Position',[ypos xpos*0 width hight])
    
    zz(1:200,1:200)=0;
    
    for i=1:200
        for j=1:200
                zz(j,i)=media_8000{9}(i,j);
        end
    end
    
    s=pcolor(1:200,1:200,zz)
    hold on
    divide(1:200)=100;
    plot(1:200,divide,'w--');
    s.EdgeColor = 'none';
    ax=gca;
    zlim([0 1000]);
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
    colormap(ax,jet);
    view(azymuth,elevation);
    
