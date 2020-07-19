function [outMat,inMat,em] = getSecAbsExcMets(fluxLogFileName,models,layout)

% Function to get secreted, absorbed, and exchanged metabolites from a
% COMETS run. Gets metabolites from all timepoints.
%
% Outputs: 
%   outMat: NxM (N = metabolites in layout, M = models) matrix with
%   greatest secretion fluxes in simulation.
%
%   inMat: NxM (N = metabolites in layout, M = models) matrix with
%   greatest absorptoin fluxes in simulation.
%
%   em: Edge table with the following columns:
%       1: secreting organism 
%       2: receiving organism 
%       3: metabolite number (from layout mets)
% 
% Alan R. Pacheco 11/27/18, 03/25/19, 8/5/19, 8/19/19, 1/21/20

%% Load files

%The log is a script that loads a struct named "fluxes"
run(fluxLogFileName)
fullMetList = layout.mets;

%% Get metabolites secreted and absorbed by each organism
modelNames = fieldnames(models);

[outMat,inMat] = deal(zeros(length(fullMetList),length(modelNames)));

for f = 1:length(fluxes)
    
    if ~isempty(fluxes{f})
    
    fluxesCurr = fluxes{f}{1}{1}; % Get only the fluxes at a certain timepoint

    for m = 1:length(modelNames)

        modelCurr = models.(modelNames{m});
        excRxns = find(findExcRxns(modelCurr));

        outRxns = intersect(excRxns,find(fluxesCurr{m}>0));
        inRxns = intersect(excRxns,find(fluxesCurr{m}<0));
        
        [outMets,outFluxes] = deal([]); % List of secreted metabolites from the model, matched to the indices in fullMetList
        for r = 1:length(outRxns)
            outMet = modelCurr.mets(find(modelCurr.S(:,outRxns(r)) < 0));
            if length(outMet) == 1
                outMetInd = find(strcmp(fullMetList,outMet));
                if length(outMetInd) == 1
                    outMets = vertcat(outMets,outMetInd);
                    outFluxes = vertcat(outFluxes,fluxesCurr{m}(outRxns(r)));
                else
                    warning(['Discrepancy in metabolite ' outMet{1} ' for model ' modelNames{m} '. Metabolite not matched.'])
                end
            else
                warning(['Metabolite discrepancy in model ' modelNames{m} ' reaction ' num2str(excRxns(r)) '. Reaction metabolite not matched.'])
            end
        end

        [inMets,inFluxes] = deal([]); % List of absorbed metabolites from the model, matched to the indices in fullMetList
        for r = 1:length(inRxns)
            inMet = modelCurr.mets(find(modelCurr.S(:,inRxns(r)) < 0));
            if length(inMet) == 1
                inMetInd = find(strcmp(fullMetList,inMet));
                if length(inMetInd) == 1
                    inMets = vertcat(inMets,inMetInd);
                    inFluxes = vertcat(inFluxes,fluxesCurr{m}(inRxns(r)));
                else
                    warning(['Discrepancy in metabolite ' inMet{1} ' for model ' modelNames{m} '. Metabolite not matched.'])
                end
            else
                warning(['Metabolite discrepancy in model ' modelNames{m} ' reaction ' num2str(excRxns(r)) '. Reaction metabolite not matched.'])
            end
        end
        
        for r = 1:length(outMets)
            if outFluxes(r) > outMat(outMets(r),m)
                outMat(outMets(r),m) = outFluxes(r);
            end
        end
        for r = 1:length(inMets)
            if inFluxes(r) < inMat(inMets(r),m)
                inMat(inMets(r),m) = inFluxes(r);
            end
        end
    end
    
    end
    
end
        
%% Combine into exchange node-edge table
em = [];
for i = 1:size(outMat,1)
    secOrgs = find(outMat(i,:));
    absOrgs = find(inMat(i,:));
    
    for j = 1:length(secOrgs)
        for k = 1:length(absOrgs)
            em = vertcat(em,[secOrgs(j) absOrgs(k) i]);
        end
    end
end