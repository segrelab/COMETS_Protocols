SMATRIX  1  2
    1   1   -1.0
    1   2   -1.0
//
BOUNDS 0 1000
    1   -1000.0   1000.0
//
OBJECTIVE
    2
//
METABOLITE_NAMES
    carbon
//
REACTION_NAMES
    Carbon_exch
    Biomass
//
EXCHANGE_REACTIONS
 1
//
packedDensity 0.5
//
elasticModulus 0.0001
//
frictionConstant 1.0
//
convDiffConstant 0.0
//
noiseVariance 20.0
//
OBJECTIVE_STYLE
MAXIMIZE_OBJECTIVE_FLUX
//
OPTIMIZER GUROBI
//
