{
    open Parser
    open Lexing

    exception Error of string

    let error lexbuf =
        raise(Error ("Unexpected char: " ^ lexeme lexbuf ^ " at " ^ string_of_int (lexeme_start lexbuf) ^ "-" ^ string_of_int (lexeme_end lexbuf)))

    let ident =
        let kws = Hashtbl.create 20 in 
        List.iter (fun (kw, token) -> Hashtbl.add kws kw token)
            [
                "class", CLASS;
                "interface", INTERFACE;
                "public", PUBLIC;
                "private", PRIVATE;
                "extends", EXTENDS;
                "implements", IMPLEMENTS;
                "static", STATIC;
                "protected", PROTECTED;
                "abstract", ABSTRACT;
                "transient", TRANSIENT;
                "final", FINAL;
            ];
            fun id ->
                match Hashtbl.find_opt kws id with
                | Some kw -> kw
                | None -> ID id
    
    let cident =
        let kws = Hashtbl.create 20 in
        List.iter (fun (kw, token) -> Hashtbl.add kws kw token)
        [
            "Enum", ENUM;
            "String", STRING;
            "Scanner", SCANNER;
        ]
}

rule token = parse 

| '\n'      {new_line lexbuf; token lexbuf}

| [' ' '\t'] {token lexbuf}

| "//"[^'\n']* {token lexbuf}

| "{"       { AO }
| "}"       { AF }
| "("       { PO }
| ")"       { PF }
| "<"       { CO }
| ">"       { CF }

| ['a'-'z'](['A'-'Z''a'-'z''0'-'9']|"-"|"_")* as n 
    { ident n }

| ['A'-'Z'](['A'-'Z''a'-'z''0'-'9']|"-"|"_")* as n
                { CID n }


| eof {EOF}

| _     { error lexbuf }