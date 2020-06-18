%Import model from SBML
ecoli = readCbModel('e_coli_core.xml');
%Set the name of the model file
ecoli.description='e_coli_core';

%Create COMETS format model
%writeCometsModel(ecoli,'Ecoli_core.txt')

%Build & populate a layout
world = CometsLayout();
world = world.addModel(ecoli);
 
%Manipulate the layout, create 1x1 spatial grid
x = 1;
y = 1;
world = world.setDims(x,y);

%Set the nutrients amounts [mmol]
%First set glucose to 0.5% or 0.02775 mmol/cm^3
world = world.setMedia('glc__D[e]',0.011);
%Set NH4, O2, Pi, H2O and H to extremely high value.
%These are not limiting nutrients
world = world.setMedia('nh4[e]',1000);
world = world.setMedia('pi[e]',1000);
world = world.setMedia('h2o[e]',1000);
world = world.setMedia('h[e]',1000);

world = world.setMedia('o2[e]',0);

%Add initial population, default is 1e-6 grams.
world = setInitialPop(world, '1x1', 5e-6);

%Generate Comets files
writeCometsLayout(world,'./','Ecoli_batch_layout.txt',0);
