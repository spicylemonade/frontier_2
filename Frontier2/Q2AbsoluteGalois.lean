import Mathlib.FieldTheory.AbsoluteGaloisGroup
import Mathlib.FieldTheory.Galois.Profinite
import Mathlib.NumberTheory.Padics.PadicNumbers

noncomputable section

open scoped Topology

namespace Frontier2.Q2AbsoluteGalois

abbrev Q2 := ℚ_[2]

abbrev GQ2 := Field.absoluteGaloisGroup Q2

instance : IsGalois Q2 (AlgebraicClosure Q2) := by
  infer_instance

instance : CompactSpace GQ2 := by
  dsimp [GQ2, Field.absoluteGaloisGroup]
  infer_instance

instance : TotallySeparatedSpace GQ2 := by
  dsimp [GQ2, Field.absoluteGaloisGroup]
  infer_instance

instance : TotallyDisconnectedSpace GQ2 := by
  infer_instance

instance : T2Space GQ2 := by
  dsimp [GQ2, Field.absoluteGaloisGroup]
  exact krullTopology_t2 (K := Q2) (L := AlgebraicClosure Q2)

abbrev profiniteGroup : ProfiniteGrp :=
  InfiniteGalois.profiniteGalGrp Q2 (AlgebraicClosure Q2)

theorem profiniteGroup_def :
    profiniteGroup = ProfiniteGrp.of GQ2 := rfl

abbrev abelianization := Field.absoluteGaloisGroupAbelianization Q2

end Frontier2.Q2AbsoluteGalois
