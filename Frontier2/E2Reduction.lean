import Mathlib

namespace Frontier2.E2Reduction

def modulus : Nat := 85667662080

def e2Reduction : Nat := 40491355905

def twoPrimaryComponent : Nat := 2 ^ 8

def threePrimaryComponent : Nat := 3 ^ 2

def oddPrimeComponents : List Nat := [5, 7, 11, 13, 17, 19, 23]

def specifiedComponents : List Nat :=
  [twoPrimaryComponent, threePrimaryComponent] ++ oddPrimeComponents

def SatisfiesE2Congruences (n : Nat) : Prop :=
  n < modulus ∧
    n ≡ 1 [MOD twoPrimaryComponent] ∧
    n ≡ 0 [MOD threePrimaryComponent] ∧
    n ≡ 0 [MOD 5] ∧
    n ≡ 0 [MOD 7] ∧
    n ≡ 0 [MOD 11] ∧
    n ≡ 0 [MOD 13] ∧
    n ≡ 0 [MOD 17] ∧
    n ≡ 0 [MOD 19] ∧
    n ≡ 0 [MOD 23]

theorem modulus_factorization :
    modulus = 2 ^ 8 * 3 ^ 2 * 5 * 7 * 11 * 13 * 17 * 19 * 23 := by
  native_decide

theorem e2Reduction_lt_modulus : e2Reduction < modulus := by
  native_decide

theorem e2Reduction_modEq_twoPrimary : e2Reduction ≡ 1 [MOD twoPrimaryComponent] := by
  native_decide

theorem e2Reduction_modEq_threePrimary : e2Reduction ≡ 0 [MOD threePrimaryComponent] := by
  native_decide

theorem e2Reduction_modEq_five : e2Reduction ≡ 0 [MOD 5] := by
  native_decide

theorem e2Reduction_modEq_seven : e2Reduction ≡ 0 [MOD 7] := by
  native_decide

theorem e2Reduction_modEq_eleven : e2Reduction ≡ 0 [MOD 11] := by
  native_decide

theorem e2Reduction_modEq_thirteen : e2Reduction ≡ 0 [MOD 13] := by
  native_decide

theorem e2Reduction_modEq_seventeen : e2Reduction ≡ 0 [MOD 17] := by
  native_decide

theorem e2Reduction_modEq_nineteen : e2Reduction ≡ 0 [MOD 19] := by
  native_decide

theorem e2Reduction_modEq_twentyThree : e2Reduction ≡ 0 [MOD 23] := by
  native_decide

theorem e2Reduction_mod_twoPrimary : e2Reduction % twoPrimaryComponent = 1 := by
  native_decide

theorem e2Reduction_mod_threePrimary : e2Reduction % threePrimaryComponent = 0 := by
  native_decide

theorem e2Reduction_satisfies : SatisfiesE2Congruences e2Reduction := by
  refine ⟨e2Reduction_lt_modulus, e2Reduction_modEq_twoPrimary, e2Reduction_modEq_threePrimary,
    e2Reduction_modEq_five, e2Reduction_modEq_seven, e2Reduction_modEq_eleven,
    e2Reduction_modEq_thirteen, e2Reduction_modEq_seventeen, e2Reduction_modEq_nineteen,
    e2Reduction_modEq_twentyThree⟩

end Frontier2.E2Reduction
