%Load the biomass output
load 'total_biomass_replica1_noise0_001.txt'
load 'total_biomass_replica2_noise0_001.txt'
load 'total_biomass_replica3_noise0_001.txt'

%The timestep (in hours) is defined in the package_params.txt file
timeStep=0.025;


%Plot the biomass (in g) as a function of time (in hours) 
biomass_plot = plot(timeStep*total_biomass_replica1_noise0_001(1:100:2501,1),total_biomass_replica1_noise0_001(1:100:2501,2)+total_biomass_replica1_noise0_001(1:100:2501,3),'*b')
hold on
biomass_plot = plot(timeStep*total_biomass_replica2_noise0_001(1:100:2501,1),total_biomass_replica2_noise0_001(1:100:2501,2)+total_biomass_replica2_noise0_001(1:100:2501,2),'or')
hold on
biomass_plot = plot(timeStep*total_biomass_replica3_noise0_001(1:100:2501,1),total_biomass_replica3_noise0_001(1:100:2501,2)+total_biomass_replica3_noise0_001(1:100:2501,2),'xk')
hold on

set(gca,'box','off')
set(gca,'FontName','Helvetica');
set(gca,'FontSize',15);
%set(biomass_plot,'LineWidth',2);
xlabel 'Time (h)'
ylabel 'Biomass (g)'
legend('replica 1','replica 2','replica 3')
set(gcf,'PaperPosition',[1.3333 3.3125 5.8333 4.3750])
%print('Ecoli_core_3replicas','-dpng')

