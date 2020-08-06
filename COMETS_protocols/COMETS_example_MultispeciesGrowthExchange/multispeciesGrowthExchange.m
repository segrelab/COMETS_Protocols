%% Load files and prepare COMETS layout

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
layout.params.maxCycles = 1200;
layout.params.deathRate = 0.1;

%% Prepare metabolic models
for m = 1:length(modelNames)
    modelCurr = models.(modelNames{m});
    minMedMets = find(ismember(modelCurr.mets,minMed));
    for i = 1:length(minMedMets)
        modelCurr.lb(intersect(find(findExcRxns(modelCurr)),find(modelCurr.S(minMedMets(i),:)))) = -1000; % Allow unlimited uptake of nonlimiting nutrients
    end
    limitingMets = find(ismember(modelCurr.mets,nutrients));
    for i = 1:length(limitingMets)
        modelCurr.lb(intersect(find(findExcRxns(modelCurr)),find(modelCurr.S(limitingMets(i),:)))) = -10; % Allow limited uptake of limiting nutrients
    end
    models.(modelNames{m}) = modelCurr;
end

%% Run COMETS
runComets(layout,cometsDirectory)

%% Analyze biomass and media logs
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
plotColors = parula(length(modelNames));
for m = 1:length(modelNames)
    plot([1:layout.params.maxCycles+1]*layout.params.timeStep,biomassLog(:,m),'LineWidth',4,'Color',plotColors(m,:))
    hold on
end
set(gca,'FontSize',16)
ylabel('Biomass (gDW)')
xlabel('Time (h)')
legend(modelNamesFormatted)
xlim([0,12])

allMetsFromModels = layout.mets;
COMETSCycles = layout.params.maxCycles;
mediaLogMat = zeros(length(allMetsFromModels),COMETSCycles);

mediaLogRaw = parseMediaLog([cometsDirectory '/' layout.params.mediaLogName]);
mediaLogMetOrder = zeros(length(allMetsFromModels),1);

% Re-order the medium components to match the list in layout.mets
for i = 1:length(allMetsFromModels)
    mediaLogMetOrder(i) = find(ismember(mediaLogRaw.metname(1:length(allMetsFromModels)),allMetsFromModels(i)));
end

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

selectSecMets = {'ac[e]','for[e]'};
selectSecMetIndices = intersect(find(ismember(allMetsFromModels,selectSecMets)),nonzeroSecMetIndices);

figure
plotColors2 = winter(2);
for s = 1:length(selectSecMets)
    plot([1:layout.params.maxCycles]*layout.params.timeStep,smoothdata(mediaLogMat(selectSecMetIndices(s),:)'),'LineWidth',4,'Color',plotColors2(s,:))
    hold on
end
set(gca,'FontSize',22.5)
ylabel('Metabolite Amount (mmol)')
xlabel('Time (h)')
legend(selectSecMets)
