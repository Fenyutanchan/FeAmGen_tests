using SymEngine
using FeAmGen
using Test

@vars K1, K2, K3, K4, m1, m2, m3, m4, mt2


@testset "Test generate_kin_relation_v2" begin

  #------------------------
  mom_list = [ K1, K2, K3 ]
  mass2_list = [ m1, m2, m3 ]
  kin_relation = FeAmGen.generate_kin_relation_v2( 2, 1, mom_list, mass2_list )

  kin_relation_bench = Dict{Basic,Basic}(
  Basic("SP(K2, K3)") => Basic("(-1/2)*m1 + (1/2)*m2 + (1/2)*m3"), 
  Basic("SP(K2, K2)") => Basic("m2"), 
  Basic("SP(K1, K2)") => Basic("(-1/2)*m1 + (-1/2)*m2 + (1/2)*m3"), 
  Basic("SP(K1, K3)") => Basic("(1/2)*m1 + (-1/2)*m2 + (1/2)*m3"), 
  Basic("SP(K3, K3)") => Basic("m3"), 
  Basic("SP(K1, K1)") => Basic("m1") )

  @test kin_relation == kin_relation_bench
  #------------------------


#mom_list = [ K1, K2, K3, K4 ]
#mass2_list = [ 0, 0, mt2, mt2 ]

#mom_list = [ K1, K2 ]
#mass2_list = [ mt2, mt2 ]

end # @testset


