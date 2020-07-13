load modelsCommunity.mat

layout = CometsLayout();
modelNames = fieldnames(models);
for m = 1:length(modelNames)
    layout = addModel(layout,models.(modelNames{m}));
end

load mediumCommunity.mat

for mm = 1:length(minMed)
    layout = layout.setMedia(minMed{mm},1000);
end

for n = 1:length(nutrients)
    layout = layout.setMedia(nutrients{n},5e-4);
end

layout.initial_pop = ones(length(modelNames),1).*1e-7;

cometsDirectory = 'CometsRunDir';

layout.params.writeBiomassLog = true;
layout.params.biomassLogRate = 1;
layout.params.biomassLogName = 'biomassLog';
layout.params.writeMediaLog = true;
layout.params.mediaLogRate = 1;
layout.params.mediaLogName = 'mediaLog';
layout.params.writeFluxLog = true;
layout.params.fluxLogRate = 1;
layout.params.fluxLogName = 'fluxLog.m';

layout.params.maxSpaceBiomass = 1e3;
layout.params.timeStep = 0.01;
layout.params.maxCycles = 2400;
layout.params.deathRate = 0.1;

% runCometsOnDirectory(cometsDirectory)

biomassLogRaw = parseBiomassLog([cometsDirectory '/' layout.params.biomassLogName]);
biomassLog = zeros(size(biomassLogRaw,1)/length(modelNames),length(modelNames));
for i = 1:length(modelNames)
    biomassLog(:,i) = biomassLogRaw.biomass(i:length(modelNames):end);
end
startBiomass = layout.initial_pop;
finalBiomass = biomassLog(end,:);
deltaBiomass = finalBiomass - startBiomass;
totalBiomass = sum(finalBiomass);

modelNamesFormatted = cell(length(modelNames),1);
for m = 1:length(modelNames)
    s = split(modelNames{m},'_');
    modelNamesFormatted{m} = [s{1} '. ' s{2}];
end

close all
figure
plot([1:layout.params.maxCycles+1]*layout.params.timeStep,biomassLog,'LineWidth',4)
set(gca,'FontSize',16)
ylabel('Biomass (gDW)')
xlabel('Time (h)')
legend(modelNamesFormatted)

allMetsFromModels = layout.mets;
COMETSCycles = layout.params.maxCycles;
mediaLogMat = zeros(length(allMetsFromModels),COMETSCycles);

mediaLogRaw = parseMediaLog([cometsDirectory '/' layout.params.mediaLogName]);
mediaLogMetOrder = zeros(length(allMetsFromModels),1);

% Re-order the medium components to match the list in layout.mets
for i = 1:length(allMetsFromModels)
    mediaLogMetOrder(i) = find(ismember(mediaLogRaw.metname(1:length(allMetsFromModels)),allMetsFromModels(i)));
end

startMedia = mediaLogRaw.amt(find(mediaLogRaw.t == 0));
startMedia = startMedia(mediaLogMetOrder);
endpointMedia = mediaLogRaw.amt(find(mediaLogRaw.t == COMETSCycles));
endpointMedia = endpointMedia(mediaLogMetOrder);

for i = 1:COMETSCycles
    currentMedia = mediaLogRaw.amt(find(mediaLogRaw.t == i));
    mediaLogMat(:,i) = currentMedia(mediaLogMetOrder);
end

nutrientsToPlot = zeros(length(nutrients),1);
for i = 1:length(nutrients)
    nutrientsToPlot(i) = find(ismember(allMetsFromModels,nutrients{i}));
end
figure
plot([1:layout.params.maxCycles]*layout.params.timeStep,mediaLogMat(nutrientsToPlot,:)','LineWidth',4)
set(gca,'FontSize',16)
ylabel('Nutrient Amount (mmol)')
xlabel('Time (h)')
legend(nutrientNames)

[secMets,absMets,excTable] = getSecAbsExcMets([cometsDirectory '/' layout.params.fluxLogName],models,layout);

nonzeroSecMetIndices = find(sum(secMets,2));

selectSecMets = {'ac[e]','ala-L[e]','for[e]'};
selectSecMetIndices = intersect(find(ismember(allMetsFromModels,selectSecMets)),nonzeroSecMetIndices);

figure
plot([1:layout.params.maxCycles]*layout.params.timeStep,mediaLogMat(selectSecMetIndices,:)','LineWidth',4)
set(gca,'FontSize',16)
ylabel('Metabolite Amount (mmol)')
xlabel('Time (h)')
legend(selectSecMets)
