%Load the biomass output
load 'total_biomass.txt'

%The timestep (in hours) is defined in the package_params.txt file
timeStep=0.01;

%Spatial grid point volume in litres
volume=1e-3;

%Plot the biomass density (in g/l) as a function of time (in hours) 
biomass_plot = plot(timeStep*total_biomass(:,1),total_biomass(:,2)/volume)

set(gca,'FontName','Helvetica');
set(gca,'FontSize',15);
set(biomass_plot,'LineWidth',2);
xlabel 'Time [h]'
ylabel 'Biomass density [g/l]'
print('Ecoli_core_batch_biomass','-dpng')