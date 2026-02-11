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

%type <programme> prog
%type <typ> typ

%start <Ast.AstSyntax.programme> main

%%

main : lfi=prog EOF   {lfi}

prog : lb=bloc*       {ClassDiagram (lb)}

fonc : 


bloc : 
| 