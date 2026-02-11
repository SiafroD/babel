/* Imports */

%{
    open Type
    open Ast.AstSyntax 
%}

%token <string> ID
%token <string> CID
%token CLASS
%token INTERFACE
%token PUBLIC
%token PRIVATE
%token EXTENDS
%token IMPLEMENTS
%token STATIC
%token PROTECTED
%token ABSTRACT
%token TRANSIENT
%token FINAL

%token AO
%token AF
%token PO
%token PF
%token CO
%token CF
%token VIRG

%token SPACE

%type <programme> prog
%type <typ> typ

%start <Ast.AstSyntax.programme> main

%%

main : lfi=prog EOF   {lfi}

prog : lb=bloc*       {ClassDiagram (lb)}

class : lk=separated_list(SPACE,keyword) ct=ctype c=CID l=links* AO lv=var* lm=fonc* AF  {Class (c,ct,lk,lv,lm)}


fonc : lk=separated_list(SPACE,keyword) t=typ n=ID PO separated_list(VIRG,param) PF  {Function(n,t,lk)}

param : t=typ n=ID

var : lk=keyword* t=typ n=ID PV    {Variable (t,n,lk)}

ctype : CLASS       {"class"}
| INTERFACE         {"interface"}

bloc : rest* lc=class* rest* {lc}


keyword :
STATIC          {}
| ABSTRACT      {"abstract"}
| TRANSIENT     {}
| FINAL         {}
| PUBLIC        {"+"}
| PRIVATE       {"-"}
| PROTECTED     {"#"}

links :
IMPLEMENTS c=CID     {"implements",c}
| EXTENDS  c=CID     {"extends",c}
| _                  {}

rest :
| _                 {}