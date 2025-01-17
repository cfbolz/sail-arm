chapter \<open>Generated by Lem from \<open>show.lem\<close>.\<close>

theory "Lem_show" 

imports
  Main
  "Lem_string"
  "Lem_maybe"
  "Lem_num"
  "Lem_basic_classes"

begin 



\<comment> \<open>\<open>open import String Maybe Num Basic_classes\<close>\<close>

\<comment> \<open>\<open>open import {hol} `lemTheory`\<close>\<close>

record 'a Show_class=

  show_method::" 'a \<Rightarrow> string "



definition instance_Show_Show_string_dict  :: \<open>(string)Show_class \<close>  where 
     \<open> instance_Show_Show_string_dict = ((|

  show_method = ((\<lambda> s. ([(CHR 0x22)]) @ (s @ ([(CHR 0x22)]))))|) )\<close>


\<comment> \<open>\<open>val stringFromMaybe : forall 'a. ('a -> string) -> maybe 'a -> string\<close>\<close>
fun stringFromMaybe  :: \<open>('a \<Rightarrow> string)\<Rightarrow> 'a option \<Rightarrow> string \<close>  where 
     \<open> stringFromMaybe showX (Some x) = ( (''Just ('') @ (showX x @ ('')'')))\<close> 
  for  "showX"  :: " 'a \<Rightarrow> string " 
  and  "x"  :: " 'a "
|\<open> stringFromMaybe showX None = ( (''Nothing''))\<close> 
  for  "showX"  :: " 'a \<Rightarrow> string "


definition instance_Show_Show_Maybe_maybe_dict  :: \<open> 'a Show_class \<Rightarrow>('a option)Show_class \<close>  where 
     \<open> instance_Show_Show_Maybe_maybe_dict dict_Show_Show_a = ((|

  show_method = ((\<lambda> x_opt. stringFromMaybe 
  (show_method   dict_Show_Show_a) x_opt))|) )\<close> 
  for  "dict_Show_Show_a"  :: " 'a Show_class "


\<comment> \<open>\<open>val stringFromListAux : forall 'a. ('a -> string) -> list 'a -> string\<close>\<close>
function (sequential,domintros)  stringFromListAux  :: \<open>('a \<Rightarrow> string)\<Rightarrow> 'a list \<Rightarrow> string \<close>  where 
     \<open> stringFromListAux showX ([]) = ( (''''))\<close> 
  for  "showX"  :: " 'a \<Rightarrow> string "
|\<open> stringFromListAux showX (x # xs') = (
      (case  xs' of
        [] => showX x
      | _ => showX x @ ((''; '') @ stringFromListAux showX xs')
      ))\<close> 
  for  "showX"  :: " 'a \<Rightarrow> string " 
  and  "xs'"  :: " 'a list " 
  and  "x"  :: " 'a " 
by pat_completeness auto


\<comment> \<open>\<open>val stringFromList : forall 'a. ('a -> string) -> list 'a -> string\<close>\<close>
definition stringFromList  :: \<open>('a \<Rightarrow> string)\<Rightarrow> 'a list \<Rightarrow> string \<close>  where 
     \<open> stringFromList showX xs = (
  (''['') @ (stringFromListAux showX xs @ ('']'')))\<close> 
  for  "showX"  :: " 'a \<Rightarrow> string " 
  and  "xs"  :: " 'a list "


definition instance_Show_Show_list_dict  :: \<open> 'a Show_class \<Rightarrow>('a list)Show_class \<close>  where 
     \<open> instance_Show_Show_list_dict dict_Show_Show_a = ((|

  show_method = ((\<lambda> xs. stringFromList 
  (show_method   dict_Show_Show_a) xs))|) )\<close> 
  for  "dict_Show_Show_a"  :: " 'a Show_class "


\<comment> \<open>\<open>val stringFromPair : forall 'a 'b. ('a -> string) -> ('b -> string) -> ('a * 'b) -> string\<close>\<close>
fun stringFromPair  :: \<open>('a \<Rightarrow> string)\<Rightarrow>('b \<Rightarrow> string)\<Rightarrow> 'a*'b \<Rightarrow> string \<close>  where 
     \<open> stringFromPair showX showY (x,y) = (
  (''('') @ (showX x @ (('', '') @ (showY y @ ('')'')))))\<close> 
  for  "showX"  :: " 'a \<Rightarrow> string " 
  and  "showY"  :: " 'b \<Rightarrow> string " 
  and  "y"  :: " 'b " 
  and  "x"  :: " 'a "


definition instance_Show_Show_tup2_dict  :: \<open> 'a Show_class \<Rightarrow> 'b Show_class \<Rightarrow>('a*'b)Show_class \<close>  where 
     \<open> instance_Show_Show_tup2_dict dict_Show_Show_a dict_Show_Show_b = ((|

  show_method = (stringFromPair 
  (show_method   dict_Show_Show_a) (show_method   dict_Show_Show_b))|) )\<close> 
  for  "dict_Show_Show_a"  :: " 'a Show_class " 
  and  "dict_Show_Show_b"  :: " 'b Show_class "


definition instance_Show_Show_bool_dict  :: \<open>(bool)Show_class \<close>  where 
     \<open> instance_Show_Show_bool_dict = ((|

  show_method = ((\<lambda> b. if b then (''true'') else (''false'')))|) )\<close>

end
