import Frontier2.Q2Presentation

namespace Frontier2

/-- Bibliographic metadata for an external theorem used by this project. -/
structure Citation where
  authors : String
  title : String
  venue : String
  year : Nat
  pages : String := ""
  note : String := ""
deriving Repr, DecidableEq

/-- How directly the bibliography supports the packaged presentation claim. -/
inductive SupportStatus where
  | exactTheorem
  | sourcedAssumption
deriving Repr, DecidableEq

/-- The semantic claim that the profinite group `G` is presented by the concrete
presentation object `P`.

This project currently treats this relation abstractly: the syntax of the
presentation is formalized in Lean, but the general theory of free profinite
groups and quotients by profinite relations has not yet been developed here. -/
inductive IsPresentedBy : ProfiniteGrp → Frontier2.Q2Presentation.Presentation → Prop

/-- A profinite presentation together with explicit bibliography for the theorem
certifying that it presents the target group. -/
structure CitedPresentation where
  group : ProfiniteGrp
  presentation : Frontier2.Q2Presentation.Presentation
  primarySource : Citation
  secondarySource : Citation
  additionalSources : List Citation := []
  supportStatus : SupportStatus := .exactTheorem
  supportNote : String := ""
  isPresented : IsPresentedBy group presentation

end Frontier2
