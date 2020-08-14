%Load the biomass output
load 'total_biomass.txt'

%The timestep (in hours) is defined in the package_params.txt file
timeStep=0.01;

%Spatial grid point volume in litres
volume=1e-3;

figure(1)

subplot(1,2,1)
%Plot the biomass density (in g/l) as a function of time (in hours) 
biomass_plot = plot(timeStep*total_biomass(:,1),total_biomass(:,2)/volume)

set(gca,'FontName','Helvetica');
set(gca,'FontSize',15);
set(biomass_plot,'LineWidth',2);
xlabel 'Time (h)'
ylabel 'Biomass density (g/l)'
print('Ecoli_core_batch_biomass','-dpng')
set(gcf,'PaperPosition',[1.3333 3.3125 5.8333 4.3750])

%Load the media output
%It contains the metabolite names in the string array media_names
media

%Choose the metabolites to be plotted
%Here we choose glucose, acetate, formate and ethanol 
metabolites_to_plot = [9 1 6 5];
metabolites_names = ["glucose" "acetate" "formate" "ethanol"];

%The time step (in hours) is defined in the package_params.txt file
timeStep=0.01;

%Spatial grid point volume in litres
volume=1e-3;

%Media write step
mediaLogRate = 10;

%Number of simulation steps
maxCycles = 1000;

%Number of wmedia write steps
total_write_steps = maxCycles/mediaLogRate;

subplot(1,2,2)

for j=1:length(metabolites_to_plot)
    for i=0:total_write_steps
        varname=genvarname(['media_',num2str(i*mediaLogRate)]);
        var=eval(varname);
        metabolite_variable=var(metabolites_to_plot(j));
        metabolite=full(metabolite_variable{1});
        
        metabolite_density(i+1,metabolites_to_plot(j))=metabolite/volume;
        time(i+1)=timeStep*mediaLogRate*i;
    end
        metabolites_plot=plot(time,metabolite_density(:,metabolites_to_plot(j)))
        set(metabolites_plot,'LineWidth',2);
        hold on
end

set(gca,'FontName','Helvetica');
set(gca,'FontSize',15);

xlabel 'Time (h)'
ylabel 'Concentration (mM)'
legend(metabolites_names,'Location','northwest');
set(gcf,'PaperPosition',[1.3333 3.3125 5.8333 4.3750])
set(gcf,'Position',[100 100 1500 513])

exportgraphics(gcf,'Ecoli_core_batch_biomass_metabolites.pdf','ContentType','vector')