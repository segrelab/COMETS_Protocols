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

%Line styles for the plot
lines_vec = {'-', '--', ':', '-.'};

for j=1:length(metabolites_to_plot)
    for i=0:total_write_steps
        varname=genvarname(['media_',num2str(i*mediaLogRate)]);
        var=eval(varname);
        metabolite_variable=var(metabolites_to_plot(j));
        metabolite=full(metabolite_variable{1});
        
        metabolite_density(i+1,metabolites_to_plot(j))=metabolite/volume;
        time(i+1)=timeStep*mediaLogRate*i;
    end
        metabolites_plot=plot(time,metabolite_density(:,metabolites_to_plot(j)),'LineStyle',lines_vec{j})
        set(metabolites_plot,'LineWidth',2);
        hold on
end

set(gca,'FontName','Helvetica');
set(gca,'FontSize',15);

xlabel 'Time [h]'
ylabel 'Concentration [mM]'
legend(metabolites_names,'Location','northwest');
print('Ecoli_core_batch_metabolites','-dpng')