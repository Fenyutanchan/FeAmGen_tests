using SymEngine, FeAmGen, Test, YAML, JLD2, Dates, Pipe

start = now()
@info "top_self_Test starts @ $(start)"

#----------------------------------------------------------------------------
# top self energy 1-loop, 2-loop including tbW vertices tests
#----------------------------------------------------------------------------
generic_seed_proc_yaml_str( ; nloop::Int64 = 2::Int64 ) = """
# input file for calculation details
# model related information

# model name
model_name: "sm_tbW"

# use unitary_gauge for internal vector boson
unitary_gauge: true

# content of "quark-parton", the "parton" will also contain gluon. Only for seed program.
#const partons = Array{String,1}( [ "g", "u", "d", "ubar", "dbar", "s", "c", "b", "sbar", "cbar", "bbar" ] )   
# for single top @ NNLO
#const partons = Array{String,1}( [ "g", "u", "d", "ubar", "dbar", "b", "bbar" ] )   
# for Higgs+Jet @ NLO
partons: [ "g", "u", "ubar", "d", "dbar", "b", "bbar" ] 

# only for seed program
AllowLeptonNumberViolation: false
AllowQuarkGenerationViolation: false

# process information
DropTadpole: true              # drop tadpole?
DropWFcorrection: true         # drop WFcorrection?

# number of loops
n_loop: $(nloop)
# order of QCD counter-term vertices
QCDCT_order: 0   

# order of QCD coupling gs in the amplitude
Amp_QCD_order: $(2*(nloop-1)) 
# order of QED coupling ee in the amplitude
Amp_QED_order: 0  
# order of special coupling in the amplitude
Amp_SPC_order: 2  

# min ep power in the amplitude
Amp_Min_Ep_Xpt: $(-2*nloop)
# max ep power in the amplitude
Amp_Max_Ep_Xpt: 0

# incoming and outgoing information
incoming: [ "t" ]          # incoming particles
outgoing: [ "t" ]               # outgoing particles 

# whether to check the consistency between two versions of amplitudes
check_consistency: false

"""

for nloop in [4]

  open( "top_seed_proc_$(nloop)Loop.yaml", "w" ) do infile
    write( infile, generic_seed_proc_yaml_str(nloop=nloop) )
  end # close

  digest_seed_proc( "top_seed_proc_$(nloop)Loop.yaml" )

  generate_amp( "t_TO_t_$(nloop)Loop/t_TO_t.yaml" )

end # for nloop

@info "top_self_Test ends @ $(now()) started from $(start)"


