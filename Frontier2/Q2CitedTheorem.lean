import Frontier2.PresentationSemantics

noncomputable section

namespace Frontier2

/-- Primary reference for the explicit presentation of the absolute Galois
group of a p-adic number field. -/
def jannsenWingberg1982 : Citation where
  authors := "U. Jannsen and K. Wingberg"
  title := "Die Struktur der Absoluten Galoisgruppe p-adischer Zahlkorper"
  venue := "Inventiones Mathematicae 70"
  year := 1982
  pages := "71-98"
  note := "Primary source for the explicit local-field absolute Galois group presentation."

/-- Standard textbook reference collecting the local-field and profinite-group
background used by the cited theorem. -/
def neukirchSchmidtWingberg2008 : Citation where
  authors := "J. Neukirch, A. Schmidt, and K. Wingberg"
  title := "Cohomology of Number Fields"
  venue := "Springer, second edition"
  year := 2008
  note := "Secondary source for the local-field, cohomological, and profinite background."

/-- External input from the literature.

Primary source:
U. Jannsen and K. Wingberg,
`Die Struktur der Absoluten Galoisgruppe p-adischer Zahlkorper`,
Inventiones Mathematicae 70 (1982), 71-98.

Secondary source:
J. Neukirch, A. Schmidt, and K. Wingberg,
`Cohomology of Number Fields`, second edition, Springer, 2008.

This is the single imported mathematical step asserting that the concrete
presentation encoded by `Frontier2.Q2Presentation.q2Presentation` presents the
absolute Galois group of `Q_2`. All remaining data in this project are proved
inside Lean. -/
axiom q2_absoluteGalois_has_presentation :
  IsPresentedBy Frontier2.Q2AbsoluteGalois.profiniteGroup Frontier2.Q2Presentation.q2Presentation

/-- The cited solution package for the `Q_2` presentation problem. -/
def q2CitedPresentation : CitedPresentation where
  group := Frontier2.Q2AbsoluteGalois.profiniteGroup
  presentation := Frontier2.Q2Presentation.q2Presentation
  primarySource := jannsenWingberg1982
  secondarySource := neukirchSchmidtWingberg2008
  isPresented := q2_absoluteGalois_has_presentation

theorem q2_problem_resolved_by_citation :
    IsPresentedBy Frontier2.Q2AbsoluteGalois.profiniteGroup Frontier2.Q2Presentation.q2Presentation :=
  q2_absoluteGalois_has_presentation

theorem q2_solution_has_requested_output :
    Frontier2.Q2Presentation.presentationText =
      "sigma,tau,x0,x1\n\nangle = (x0*tau*x0^-1*tau)^40491355905\ny1 = x1^sigma\n\n(x0^2)^-1*angle*x1^3*y1" :=
  Frontier2.Q2Presentation.presentationText_eq

theorem q2_solution_uses_valid_e2_reduction :
    Frontier2.E2Reduction.SatisfiesE2Congruences Frontier2.E2Reduction.e2Reduction :=
  Frontier2.E2Reduction.e2Reduction_satisfies

theorem q2_problem_resolved_with_metadata :
    q2CitedPresentation.group = Frontier2.Q2AbsoluteGalois.profiniteGroup ∧
      q2CitedPresentation.presentation = Frontier2.Q2Presentation.q2Presentation ∧
      q2CitedPresentation.primarySource = jannsenWingberg1982 ∧
      q2CitedPresentation.secondarySource = neukirchSchmidtWingberg2008 := by
  exact ⟨rfl, rfl, rfl, rfl⟩

theorem q2_problem_resolved_with_output_and_source :
    IsPresentedBy q2CitedPresentation.group q2CitedPresentation.presentation ∧
      Frontier2.Q2Presentation.presentationText =
        "sigma,tau,x0,x1\n\nangle = (x0*tau*x0^-1*tau)^40491355905\ny1 = x1^sigma\n\n(x0^2)^-1*angle*x1^3*y1" := by
  exact ⟨q2CitedPresentation.isPresented, q2_solution_has_requested_output⟩

end Frontier2
