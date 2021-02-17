%Load the biomass output
load 'total_biomass_dx0_01.txt'
load 'total_biomass_dx0_02.txt'
load 'total_biomass_dx0_04.txt'
load 'total_biomass_dx0_08.txt'

%The timestep (in hours) is defined in the package_params.txt file
timeStep=0.025;


%Plot the biomass (in g) as a function of time (in hours) 
biomass_plot = plot(timeStep*total_biomass_dx0_01(1:100:1001,1),total_biomass_dx0_01(1:100:1001,2)+total_biomass_dx0_01(1:100:1001,3),'*k')
hold on
biomass_plot = plot(timeStep*total_biomass_dx0_02(1:100:1001,1),total_biomass_dx0_02(1:100:1001,2)+total_biomass_dx0_02(1:100:1001,2),'og')
hold on
biomass_plot = plot(timeStep*total_biomass_dx0_04(1:100:1001,1),total_biomass_dx0_04(1:100:1001,2)+total_biomass_dx0_04(1:100:1001,2),'xb')
hold on
biomass_plot = plot(timeStep*total_biomass_dx0_08(1:100:1001,1),total_biomass_dx0_08(1:100:1001,2)+total_biomass_dx0_08(1:100:1001,2),'sr')
hold on

set(gca,'box','off')
set(gca,'FontName','Helvetica');
set(gca,'FontSize',15);
%set(biomass_plot,'LineWidth',2);
xlabel 'Time (h)'
ylabel 'Biomass (g)'
legend('\Deltax=0.01cm','\Deltax=0.02cm','\Deltax=0.04cm','\Deltax=0.08cm')
set(gcf,'PaperPosition',[1.3333 3.3125 5.8333 4.3750])
%print('Ecoli_core_3replicas','-dpng')

