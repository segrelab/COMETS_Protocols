clear all
%Import model from SBML
model = readCbModel('e_coli_core.xml');

%Run (import) the .m file with the COMETS fluxes output 
flux_8000

%Set the model number, time, X and Y coordinate of the grid point
model_number=1;
time=8000;
X=97;
Y=27;

%Open the CVS file
fileID=fopen('ReactionsFluxes_8000_97_27.cvs','w');
%Write theheader of the CVS file
fprintf(fileID,'%3s %4s %4.2f\n','ID,','time',time);

%Write the reaction names and flux values in CVS format
for reaction=1:length(model.rxns)
    %fprintf(fileID,'%s%1s%12.8f\n',model.rxns{reaction},',',fluxes{time}{X}{Y}{model}(reaction));
    fprintf(fileID,'%s%1s%f\n',model.rxns{reaction},',',fluxes{time}{X}{Y}{model_number}(reaction));
end
%Close th eoutput file
fclose(fileID);

