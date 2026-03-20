# `frontier_2`

Lean formalization work around a presentation of the absolute Galois group
`Gal(Qbar_2 / Q_2)`.

## Status

This repository formalizes the concrete presentation data

```text
sigma,tau,x0,x1

angle = (x0*tau*x0^-1*tau)^40491355905
y1 = x1^sigma

(x0^2)^-1*angle*x1^3*y1
```

and proves the supporting arithmetic and packaging around it inside Lean.

In particular, the project formalizes:

- the presentation syntax and the requested output text,
- the reduction `40491355905 mod 85667662080` for the idempotent `e_2`,
- a `Q_2` absolute Galois group target object packaged as a `ProfiniteGrp`,
- bibliography and metadata describing how the presentation claim is supported.

There are no `sorry`s in the project files.

## Formalization Boundary

The project does **not** currently prove from first principles in Lean that this
exact normalized presentation presents `Gal(Qbar_2 / Q_2)`.

Instead, the repository isolates one project-level imported assumption in
`Frontier2/Q2CitedTheorem.lean`:

- `q2_absoluteGalois_has_presentation`

This assumption records the deep local-field theorem boundary. Everything else in
the project is proved in Lean around that boundary.

The support status is intentionally recorded as a `sourcedAssumption`, not an
`exactTheorem`, because the exact `sigma,tau,x0,x1` normalization has not yet
been extracted line-by-line from the dyadic literature into Lean.

## Sources

- Primary checked dyadic source: V. Dieckert, *Uber die absolute Galoisgruppe
  dyadischer Zahlkorper*, J. Reine Angew. Math. 350 (1984), 152-172.
- Checked odd-prime analogue: U. Jannsen and K. Wingberg, *Die Struktur der
  Absoluten Galoisgruppe p-adischer Zahlkorper*, Invent. Math. 70 (1982), 71-98.
- Background sources: S. P. Demushkin (1961); J. Neukirch, A. Schmidt, and
  K. Wingberg, *Cohomology of Number Fields* (2008); M. Jarden and
  M. Shusterman (2023).

## Build

```bash
lake build Frontier2
```
