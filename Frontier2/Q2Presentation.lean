import Frontier2.E2Reduction
import Frontier2.Q2AbsoluteGalois

namespace Frontier2.Q2Presentation

abbrev modulus : Nat := Frontier2.E2Reduction.modulus

abbrev e2Reduction : Nat := Frontier2.E2Reduction.e2Reduction

noncomputable abbrev ambientGroup : ProfiniteGrp := Frontier2.Q2AbsoluteGalois.profiniteGroup

inductive Symbol where
  | sigma
  | tau
  | x0
  | x1
  | angle
  | y1
deriving DecidableEq, Repr

def Symbol.render : Symbol -> String
  | .sigma => "sigma"
  | .tau => "tau"
  | .x0 => "x0"
  | .x1 => "x1"
  | .angle => "angle"
  | .y1 => "y1"

inductive Expr where
  | one
  | atom (name : Symbol)
  | mul (lhs rhs : Expr)
  | inv (arg : Expr)
  | natPow (base : Expr) (exp : Nat)
  | hatPow (base : Expr) (expMod : Nat)
  | conj (base conjBy : Expr)
deriving DecidableEq, Repr

instance : Coe Symbol Expr := ⟨Expr.atom⟩

instance : One Expr := ⟨Expr.one⟩

instance : Mul Expr := ⟨Expr.mul⟩

instance : Inv Expr := ⟨Expr.inv⟩

instance : Pow Expr Nat := ⟨Expr.natPow⟩

def hatPow (base : Expr) (expMod : Nat) : Expr :=
  .hatPow base expMod

def conj (base conjBy : Expr) : Expr :=
  .conj base conjBy

def Expr.isAtomic : Expr -> Bool
  | .one => true
  | .atom _ => true
  | _ => false

def Expr.renderPrec : Nat -> Expr -> String
  | _, .one => "1"
  | _, .atom name => name.render
  | ctx, .mul lhs rhs =>
      let out := Expr.renderPrec 2 lhs ++ "*" ++ Expr.renderPrec 2 rhs
      if ctx > 2 then
        "(" ++ out ++ ")"
      else
        out
  | ctx, .inv arg =>
      let base :=
        if Expr.isAtomic arg then
          Expr.renderPrec 3 arg
        else
          "(" ++ Expr.renderPrec 0 arg ++ ")"
      let out := base ++ "^-1"
      if ctx > 3 then
        "(" ++ out ++ ")"
      else
        out
  | ctx, .natPow base exp =>
      let renderedBase :=
        if Expr.isAtomic base then
          Expr.renderPrec 3 base
        else
          "(" ++ Expr.renderPrec 0 base ++ ")"
      let out := renderedBase ++ "^" ++ toString exp
      if ctx > 3 then
        "(" ++ out ++ ")"
      else
        out
  | ctx, .hatPow base expMod =>
      let renderedBase :=
        if Expr.isAtomic base then
          Expr.renderPrec 3 base
        else
          "(" ++ Expr.renderPrec 0 base ++ ")"
      let out := renderedBase ++ "^" ++ toString expMod
      if ctx > 3 then
        "(" ++ out ++ ")"
      else
        out
  | ctx, .conj base conjBy =>
      let renderedBase :=
        if Expr.isAtomic base then
          Expr.renderPrec 3 base
        else
          "(" ++ Expr.renderPrec 0 base ++ ")"
      let renderedBy :=
        if Expr.isAtomic conjBy then
          Expr.renderPrec 3 conjBy
        else
          "(" ++ Expr.renderPrec 0 conjBy ++ ")"
      let out := renderedBase ++ "^" ++ renderedBy
      if ctx > 3 then
        "(" ++ out ++ ")"
      else
        out

def Expr.render (expr : Expr) : String :=
  Expr.renderPrec 0 expr

def joinComma : List String -> String
  | [] => ""
  | item :: [] => item
  | item :: rest => item ++ "," ++ joinComma rest

def joinLines : List String -> String
  | [] => ""
  | item :: [] => item
  | item :: rest => item ++ "\n" ++ joinLines rest

structure DefinitionLine where
  name : Symbol
  value : Expr
deriving Repr

def DefinitionLine.render (line : DefinitionLine) : String :=
  line.name.render ++ " = " ++ line.value.render

structure Presentation where
  generators : List Symbol
  definitions : List DefinitionLine
  relations : List Expr
deriving Repr

def sigma : Expr := .atom .sigma

def tau : Expr := .atom .tau

def x0 : Expr := .atom .x0

def x1 : Expr := .atom .x1

def angleExpanded : Expr :=
  hatPow (x0 * tau * Inv.inv x0 * tau) e2Reduction

def y1Expanded : Expr :=
  conj x1 sigma

def angle : Expr := .atom .angle

def y1 : Expr := .atom .y1

def generatorList : List Symbol :=
  [.sigma, .tau, .x0, .x1]

def definitions : List DefinitionLine :=
  [
    { name := .angle, value := angleExpanded },
    { name := .y1, value := y1Expanded }
  ]

def relator : Expr :=
  Inv.inv (x0 ^ 2) * angle * (x1 ^ 3) * y1

def relations : List Expr :=
  [relator]

def q2Presentation : Presentation where
  generators := generatorList
  definitions := definitions
  relations := relations

def variablesSection : String :=
  joinComma (generatorList.map Symbol.render)

def definitionsSection : String :=
  joinLines (definitions.map DefinitionLine.render)

def relationsSection : String :=
  joinLines (relations.map Expr.render)

def presentationText : String :=
  variablesSection ++ "\n\n" ++ definitionsSection ++ "\n\n" ++ relationsSection

theorem e2Reduction_lt_modulus : e2Reduction < modulus :=
  Frontier2.E2Reduction.e2Reduction_lt_modulus

theorem variablesSection_eq : variablesSection = "sigma,tau,x0,x1" := rfl

theorem definitionsSection_eq :
    definitionsSection = "angle = (x0*tau*x0^-1*tau)^40491355905\ny1 = x1^sigma" := rfl

theorem relationsSection_eq : relationsSection = "(x0^2)^-1*angle*x1^3*y1" := rfl

theorem presentationText_eq :
    presentationText =
      "sigma,tau,x0,x1\n\nangle = (x0*tau*x0^-1*tau)^40491355905\ny1 = x1^sigma\n\n(x0^2)^-1*angle*x1^3*y1" := rfl

end Frontier2.Q2Presentation
