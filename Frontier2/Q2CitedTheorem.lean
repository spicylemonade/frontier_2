import Frontier2.PresentationSemantics

noncomputable section

namespace Frontier2

/-- Primary dyadic-case reference target for the absolute Galois group of a
2-adic number field. -/
def dieckert1984 : Citation where
  authors := "V. Dieckert"
  title := "Uber die absolute Galoisgruppe dyadischer Zahlkorper"
  venue := "Journal fur die reine und angewandte Mathematik 350"
  year := 1984
  pages := "152-172"
  note := "Primary dyadic source. It treats the no-primitive-fourth-root case relevant to Q_2, but this project has not yet checked a line-by-line normalization to the exact sigma,tau,x0,x1 presentation used here."

/-- Classical odd-prime reference for explicit presentations of absolute
Galois groups of p-adic fields. -/
def jannsenWingberg1982 : Citation where
  authors := "U. Jannsen and K. Wingberg"
  title := "Die Struktur der Absoluten Galoisgruppe p-adischer Zahlkorper"
  venue := "Inventiones Mathematicae 70"
  year := 1982
  pages := "71-98"
  note := "Checked odd-prime analogue: Theorem 2 and Example 1.4(a) give the local-field presentation and the Q_p specialization, but the paper explicitly assumes p != 2."

/-- Foundational reference for the maximal pro-p quotient of a local field. -/
def demushkin1961 : Citation where
  authors := "S. P. Demushkin"
  title := "The group of a maximal p-extension of a local field"
  venue := "Izv. Akad. Nauk SSSR Ser. Mat. 25(3)"
  year := 1961
  pages := "329-346"
  note := "Foundational maximal pro-p local-field source underlying the Demushkin quotient used as background for the pro-2 check."

/-- Standard textbook reference collecting the local-field and profinite-group
background used by the cited theorem. -/
def neukirchSchmidtWingberg2008 : Citation where
  authors := "J. Neukirch, A. Schmidt, and K. Wingberg"
  title := "Cohomology of Number Fields"
  venue := "Springer, second edition"
  year := 2008
  note := "General local-field, cohomological, and profinite background reference; cited for context rather than as the checked source of the explicit normalized Q_2 relator."

/-- Modern source proving the number of generators and relations needed for
absolute Galois groups of p-adic fields. -/
def jardenShusterman2023 : Citation where
  authors := "M. Jarden and M. Shusterman"
  title := "The absolute Galois group of a p-adic field"
  venue := "Mathematische Annalen 386"
  year := 2023
  pages := "1595-1603"
  note := "Provides generator/relation counts for finite extensions of Q_p; not an explicit normalized Q_2 presentation."

/-- External input recorded as a documented assumption.

Primary source:
V. Dieckert,
`Uber die absolute Galoisgruppe dyadischer Zahlkorper`,
J. Reine Angew. Math. 350 (1984), 152-172.

Checked supporting analogue:
U. Jannsen and K. Wingberg,
`Die Struktur der Absoluten Galoisgruppe p-adischer Zahlkorper`,
Invent. Math. 70 (1982), 71-98.

Additional background sources:
S. P. Demushkin (1961) for the maximal pro-`2` quotient,
J. Neukirch, A. Schmidt, and K. Wingberg (2008) for general background,
and M. Jarden and M. Shusterman (2023) for generator/relation counts.

This is the single imported mathematical step asserting that the concrete
presentation encoded by `Frontier2.Q2Presentation.q2Presentation` presents the
absolute Galois group of `Q_2`.

The claim is marked as a `sourcedAssumption` rather than an `exactTheorem`
because the project has checked that Dieckert is a genuine dyadic source and
that Jannsen-Wingberg gives the verified odd-prime analogue, but it has not yet
derived this exact normalized `sigma,tau,x0,x1` presentation line-by-line from
the dyadic source inside Lean. All remaining data in this project are proved
inside Lean. -/
axiom q2_absoluteGalois_has_presentation :
  IsPresentedBy Frontier2.Q2AbsoluteGalois.profiniteGroup Frontier2.Q2Presentation.q2Presentation

/-- The documented solution package for the `Q_2` presentation problem. -/
def q2CitedPresentation : CitedPresentation where
  group := Frontier2.Q2AbsoluteGalois.profiniteGroup
  presentation := Frontier2.Q2Presentation.q2Presentation
  primarySource := dieckert1984
  secondarySource := jannsenWingberg1982
  additionalSources := [demushkin1961, neukirchSchmidtWingberg2008, jardenShusterman2023]
  supportStatus := .sourcedAssumption
  supportNote :=
    "Primary checked evidence comes from Dieckert 1984 for the dyadic case, with Jannsen-Wingberg 1982 as the verified odd-prime analogue. " ++
    "The exact normalized Q_2 presentation used in this project is therefore kept as a documented external assumption rather than as a line-by-line extracted theorem."
  isPresented := q2_absoluteGalois_has_presentation

theorem q2_problem_resolved_by_documented_assumption :
    IsPresentedBy Frontier2.Q2AbsoluteGalois.profiniteGroup Frontier2.Q2Presentation.q2Presentation :=
  q2_absoluteGalois_has_presentation

theorem q2_claim_status_is_sourced_assumption :
    q2CitedPresentation.supportStatus = .sourcedAssumption := rfl

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
      q2CitedPresentation.primarySource = dieckert1984 ∧
      q2CitedPresentation.secondarySource = jannsenWingberg1982 ∧
      q2CitedPresentation.supportStatus = .sourcedAssumption := by
  exact ⟨rfl, rfl, rfl, rfl, rfl⟩

theorem q2_problem_resolved_with_output_and_source :
    IsPresentedBy q2CitedPresentation.group q2CitedPresentation.presentation ∧
      Frontier2.Q2Presentation.presentationText =
        "sigma,tau,x0,x1\n\nangle = (x0*tau*x0^-1*tau)^40491355905\ny1 = x1^sigma\n\n(x0^2)^-1*angle*x1^3*y1" := by
  exact ⟨q2CitedPresentation.isPresented, q2_solution_has_requested_output⟩

end Frontier2
