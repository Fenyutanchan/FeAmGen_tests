using SymEngine
using FeAmGen

@vars K1, K2, K3, K4, m1, m2, m3, m4, mt2
#mom_list = [ K1, K2, K3, K4 ]
#mass2_list = [ 0, 0, mt2, mt2 ]

mom_list = [ K1, K2, K3 ]
mass2_list = [ m1, m2, m3 ]

#mom_list = [ K1, K2 ]
#mass2_list = [ mt2, mt2 ]

kin_relation = FeAmGen.generate_kin_relation_v2( 2, 1, mom_list, mass2_list )
for ele in kin_relation 
  println( ele )
end # for ele

