clear all

time=8000
    time_string=num2str(time);
    varname=genvarname(['biomass_' time_string '_0']);
    fig=figure;
    set(gcf, 'Position', [100, 100, 300, 600])
    subplot(4,1,1)
    %subplot('Position',[0 0 0.2 0.2])
    biomass_8000; 
    var=eval(varname);

    for i=1:200
        for j=1:200
            if sqrt((i-100)^2+(j-100)^2)>=99
                var(i,j)= NaN;
            end
        end
    end
    %s=surf(1:200,1:200,biomass_36000_0)%,'FaceLighting','gouraud')
    s=pcolor(1:200,1:200,var)
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
    view(-37.5,100);

    clear var
    % clear biomass_3600_0;
    subplot(4,1,2)
    for i=1:200
        for j=1:200
            fluxes{time}{i}{j}{1}=[];
            fluxes{time}{i}{j}{1}(1:95)=0.0;
        end
    end
    zz(1:200,1:200)=0;
    flux_8000;
   
    for i=1:200
        for j=1:200
            if sqrt((i-100)^2+(j-100)^2)>=99
                zz(j,i)= NaN;
            else
                zz(j,i)=fluxes{time}{i}{j}{1}(13);
            end
        end
    end

    %s=surf(1:200,1:200,zz)%,'FaceLighting','gouraud')
    s=pcolor(1:200,1:200,zz);
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
    view(-37.5,100);

    clear fluxes;

    subplot(4,1,3)
    zz(1:200,1:200)=0;
    metabolites_8000;
    
    for i=1:200
        for j=1:200
            if sqrt((i-100)^2+(j-100)^2)>=99
                zz(j,i)= NaN;
            else
                zz(j,i)=media_8000{1}(i,j);
            end
        end
    end

    %s=surf(1:200,1:200,zz)%,'FaceLighting','gouraud')
    s=pcolor(1:200,1:200,zz)
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
    view(-37.5,100);
   
    subplot(4,1,4)
    zz(1:200,1:200)=0;
    %metabolites_30000;
    
    for i=1:200
        for j=1:200
            if sqrt((i-100)^2+(j-100)^2)>=99
                zz(j,i)= NaN;
            else
                zz(j,i)=media_8000{9}(i,j);
            end
        end
    end

    %s=surf(1:200,1:200,zz)%,'FaceLighting','gouraud')
    s=pcolor(1:200,1:200,zz)
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
    view(-37.5,100);
