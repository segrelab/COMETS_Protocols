%Load the biomass output
load 'total_biomass_dt0_1.txt'
load 'total_biomass_dt0_05.txt'
load 'total_biomass_dt0_025.txt'
load 'total_biomass_dt0_01.txt'

%The timestep (in hours) is defined in the package_params.txt file
time_step1=0.1
time_step2=0.05
time_step3=0.025
time_step4=0.01


%Plot the biomass (in g) as a function of time (in hours) 
biomass_plot = plot(time_step1*total_biomass_dt0_1(1:50:801,1),total_biomass_dt0_1(1:50:801,2),'*')
hold on
biomass_plot = plot(time_step2*total_biomass_dt0_05(1:100:1601,1),total_biomass_dt0_05(1:100:1601,2),'+')
hold on
biomass_plot = plot(time_step3*total_biomass_dt0_025(1:200:3201,1),total_biomass_dt0_025(1:200:3201,2),'xg')
hold on
biomass_plot = plot(time_step4*total_biomass_dt0_01(1:500:8001,1),total_biomass_dt0_01(1:500:8001,2),'s')
hold on

set(gca,'FontName','Helvetica');
set(gca,'FontSize',15);
set(gca,'Box','off')
%set(biomass_plot,'LineWidth',2);
xlabel 'Time (h)'
ylabel 'Biomass (g)'
legend('\Deltat=0.100h','\Deltat=0.050h','\Deltat=0.025h','\Deltat=0.010h')
set(gcf,'PaperPosition',[1.3333 3.3125 5.8333 4.3750])
print('Ecoli_core_4TimeSteps','-dpng')

