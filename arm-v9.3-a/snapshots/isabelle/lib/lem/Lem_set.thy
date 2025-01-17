chapter \<open>Generated by Lem from \<open>set.lem\<close>.\<close>

theory "Lem_set" 

imports
  Main
  "Lem_bool"
  "Lem_basic_classes"
  "Lem_maybe"
  "Lem_function"
  "Lem_num"
  "Lem_list"
  "Lem_set_helpers"
  "Lem"

begin 

\<comment> \<open>\<open>****************************************************************************\<close>\<close>
\<comment> \<open>\<open> A library for sets                                                         \<close>\<close>
\<comment> \<open>\<open>                                                                            \<close>\<close>
\<comment> \<open>\<open> It mainly follows the Haskell Set-library                                  \<close>\<close>
\<comment> \<open>\<open>****************************************************************************\<close>\<close>

\<comment> \<open>\<open> Sets in Lem are a bit tricky. On the one hand, we want efficiently executable sets.
   OCaml and Haskell both represent sets by some kind of balancing trees. This means
   that sets are finite and an order on the element type is required. 
   Such sets are constructed by simple, executable operations like inserting or
   deleting elements, union, intersection, filtering etc.

   On the other hand, we want to use sets for specifications. This leads often
   infinite sets, which are specificied in complicated, perhaps even undecidable
   ways.

   The set library in this file, chooses the first approach. It describes 
   *finite* sets with an underlying order. Infinite sets should in the medium
   run be represented by a separate type. Since this would require some significant
   changes to Lem, for the moment also infinite sets are represented using this
   class. However, a run-time exception might occour when using these sets. 
   This problem needs adressing in the future. \<close>\<close>
   

\<comment> \<open>\<open> ========================================================================== \<close>\<close>
\<comment> \<open>\<open> Header                                                                     \<close>\<close>
\<comment> \<open>\<open> ========================================================================== \<close>\<close>

\<comment> \<open>\<open>open import Bool Basic_classes Maybe Function Num List Set_helpers\<close>\<close>

\<comment> \<open>\<open> DPM: sets currently implemented as lists due to mismatch between Coq type
 * class hierarchy and the hierarchy implemented in Lem.
 \<close>\<close>
\<comment> \<open>\<open>open import {coq} `Coq.Lists.List`\<close>\<close>
\<comment> \<open>\<open>open import {hol} `lemTheory`\<close>\<close>
\<comment> \<open>\<open>open import {isabelle} `$LIB_DIR/Lem`\<close>\<close>

\<comment> \<open>\<open> ----------------------- \<close>\<close>
\<comment> \<open>\<open> Equality check          \<close>\<close>
\<comment> \<open>\<open> ----------------------- \<close>\<close>

\<comment> \<open>\<open>val setEqualBy : forall 'a. ('a -> 'a -> ordering) -> set 'a -> set 'a -> bool\<close>\<close>

\<comment> \<open>\<open>val setEqual : forall 'a. SetType 'a => set 'a -> set 'a -> bool\<close>\<close>

\<comment> \<open>\<open> ----------------------- \<close>\<close>
\<comment> \<open>\<open> Empty set               \<close>\<close>
\<comment> \<open>\<open> ----------------------- \<close>\<close>

\<comment> \<open>\<open>val empty : forall 'a. SetType 'a => set 'a\<close>\<close> 
\<comment> \<open>\<open>val emptyBy : forall 'a. ('a -> 'a -> ordering) -> set 'a\<close>\<close>

\<comment> \<open>\<open> ----------------------- \<close>\<close>
\<comment> \<open>\<open> any / all               \<close>\<close>
\<comment> \<open>\<open> ----------------------- \<close>\<close>

\<comment> \<open>\<open>val any : forall 'a. SetType 'a => ('a -> bool) -> set 'a -> bool\<close>\<close>

\<comment> \<open>\<open>val all : forall 'a. SetType 'a => ('a -> bool) -> set 'a -> bool\<close>\<close>


\<comment> \<open>\<open> ----------------------- \<close>\<close>
\<comment> \<open>\<open> (IN)                    \<close>\<close>
\<comment> \<open>\<open> ----------------------- \<close>\<close>

\<comment> \<open>\<open>val IN [member] : forall 'a. SetType 'a => 'a -> set 'a -> bool\<close>\<close> 
\<comment> \<open>\<open>val memberBy : forall 'a. ('a -> 'a -> ordering) -> 'a -> set 'a -> bool\<close>\<close>

\<comment> \<open>\<open> ----------------------- \<close>\<close>
\<comment> \<open>\<open> not (IN)                \<close>\<close>
\<comment> \<open>\<open> ----------------------- \<close>\<close>

\<comment> \<open>\<open>val NIN [notMember] : forall 'a. SetType 'a => 'a -> set 'a -> bool\<close>\<close>



\<comment> \<open>\<open> ----------------------- \<close>\<close>
\<comment> \<open>\<open> Emptyness check         \<close>\<close>
\<comment> \<open>\<open> ----------------------- \<close>\<close>

\<comment> \<open>\<open>val null : forall 'a. SetType 'a => set 'a -> bool\<close>\<close>


\<comment> \<open>\<open> ------------------------ \<close>\<close>
\<comment> \<open>\<open> singleton                \<close>\<close>
\<comment> \<open>\<open> ------------------------ \<close>\<close>

\<comment> \<open>\<open>val singletonBy : forall 'a. ('a -> 'a -> ordering) -> 'a -> set 'a\<close>\<close>
\<comment> \<open>\<open>val singleton : forall 'a. SetType 'a => 'a -> set 'a\<close>\<close>


\<comment> \<open>\<open> ----------------------- \<close>\<close>
\<comment> \<open>\<open> size                    \<close>\<close>
\<comment> \<open>\<open> ----------------------- \<close>\<close>

\<comment> \<open>\<open>val size : forall 'a. SetType 'a => set 'a -> nat\<close>\<close>


\<comment> \<open>\<open> ----------------------------\<close>\<close>
\<comment> \<open>\<open> setting up pattern matching \<close>\<close>
\<comment> \<open>\<open> --------------------------- \<close>\<close>

\<comment> \<open>\<open>val set_case : forall 'a 'b. SetType 'a => set 'a -> 'b -> ('a -> 'b) -> 'b -> 'b\<close>\<close>


\<comment> \<open>\<open> ------------------------ \<close>\<close>
\<comment> \<open>\<open> union                    \<close>\<close>
\<comment> \<open>\<open> ------------------------ \<close>\<close>

\<comment> \<open>\<open>val unionBy : forall 'a. ('a -> 'a -> ordering) -> set 'a -> set 'a -> set 'a\<close>\<close>
\<comment> \<open>\<open>val union : forall 'a. SetType 'a => set 'a -> set 'a -> set 'a\<close>\<close>

\<comment> \<open>\<open> ----------------------- \<close>\<close>
\<comment> \<open>\<open> insert                  \<close>\<close>
\<comment> \<open>\<open> ----------------------- \<close>\<close>

\<comment> \<open>\<open>val insert : forall 'a. SetType 'a => 'a -> set 'a -> set 'a\<close>\<close>

\<comment> \<open>\<open> ----------------------- \<close>\<close>
\<comment> \<open>\<open> filter                  \<close>\<close>
\<comment> \<open>\<open> ----------------------- \<close>\<close>

\<comment> \<open>\<open>val filter : forall 'a. SetType 'a => ('a -> bool) -> set 'a -> set 'a\<close>\<close> 
\<comment> \<open>\<open>let filter P s=  {e | forall (e IN s) | P e}\<close>\<close>


\<comment> \<open>\<open> ----------------------- \<close>\<close>
\<comment> \<open>\<open> partition               \<close>\<close>
\<comment> \<open>\<open> ----------------------- \<close>\<close>

\<comment> \<open>\<open>val partition : forall 'a. SetType 'a => ('a -> bool) -> set 'a -> set 'a * set 'a\<close>\<close>
definition partition  :: \<open>('a \<Rightarrow> bool)\<Rightarrow> 'a set \<Rightarrow> 'a set*'a set \<close>  where 
     \<open> partition P s = ( (set_filter P s, set_filter ((\<lambda> e .  \<not> (P e))) s))\<close> 
  for  "P"  :: " 'a \<Rightarrow> bool " 
  and  "s"  :: " 'a set "



\<comment> \<open>\<open> ----------------------- \<close>\<close>
\<comment> \<open>\<open> split                   \<close>\<close>
\<comment> \<open>\<open> ----------------------- \<close>\<close>

\<comment> \<open>\<open>val split : forall 'a. SetType 'a, Ord 'a => 'a -> set 'a -> set 'a * set 'a\<close>\<close>
definition split  :: \<open> 'a Ord_class \<Rightarrow> 'a \<Rightarrow> 'a set \<Rightarrow> 'a set*'a set \<close>  where 
     \<open> split dict_Basic_classes_Ord_a p s = ( (set_filter (
  (isGreater_method   dict_Basic_classes_Ord_a) p) s, set_filter ((isLess_method   dict_Basic_classes_Ord_a) p) s))\<close> 
  for  "dict_Basic_classes_Ord_a"  :: " 'a Ord_class " 
  and  "p"  :: " 'a " 
  and  "s"  :: " 'a set "


\<comment> \<open>\<open>val splitMember : forall 'a. SetType 'a, Ord 'a => 'a -> set 'a -> set 'a * bool * set 'a\<close>\<close>
definition splitMember  :: \<open> 'a Ord_class \<Rightarrow> 'a \<Rightarrow> 'a set \<Rightarrow> 'a set*bool*'a set \<close>  where 
     \<open> splitMember dict_Basic_classes_Ord_a p s = ( (set_filter (
  (isLess_method   dict_Basic_classes_Ord_a) p) s, (p \<in> s), set_filter (
  (isGreater_method   dict_Basic_classes_Ord_a) p) s))\<close> 
  for  "dict_Basic_classes_Ord_a"  :: " 'a Ord_class " 
  and  "p"  :: " 'a " 
  and  "s"  :: " 'a set "


\<comment> \<open>\<open> ------------------------ \<close>\<close>
\<comment> \<open>\<open> subset and proper subset \<close>\<close>
\<comment> \<open>\<open> ------------------------ \<close>\<close>

\<comment> \<open>\<open>val isSubsetOfBy : forall 'a. ('a -> 'a -> ordering) -> set 'a -> set 'a -> bool\<close>\<close>
\<comment> \<open>\<open>val isProperSubsetOfBy : forall 'a. ('a -> 'a -> ordering) -> set 'a -> set 'a -> bool\<close>\<close>

\<comment> \<open>\<open>val isSubsetOf : forall 'a. SetType 'a => set 'a -> set 'a -> bool\<close>\<close>
\<comment> \<open>\<open>val isProperSubsetOf : forall 'a. SetType 'a => set 'a -> set 'a -> bool\<close>\<close>


\<comment> \<open>\<open> ------------------------ \<close>\<close>
\<comment> \<open>\<open> delete                   \<close>\<close>
\<comment> \<open>\<open> ------------------------ \<close>\<close>

\<comment> \<open>\<open>val delete : forall 'a. SetType 'a, Eq 'a => 'a -> set 'a -> set 'a\<close>\<close>
\<comment> \<open>\<open>val deleteBy : forall 'a. SetType 'a => ('a -> 'a -> bool) -> 'a -> set 'a -> set 'a\<close>\<close>


\<comment> \<open>\<open> ------------------------ \<close>\<close>
\<comment> \<open>\<open> bigunion                 \<close>\<close>
\<comment> \<open>\<open> ------------------------ \<close>\<close>

\<comment> \<open>\<open>val bigunion : forall 'a. SetType 'a => set (set 'a) -> set 'a\<close>\<close>
\<comment> \<open>\<open>val bigunionBy : forall 'a. ('a -> 'a -> ordering) -> set (set 'a) -> set 'a\<close>\<close>

\<comment> \<open>\<open>let bigunion bs=  {x | forall (s IN bs) (x IN s) | true}\<close>\<close>

\<comment> \<open>\<open> ------------------------ \<close>\<close>
\<comment> \<open>\<open> big intersection         \<close>\<close>
\<comment> \<open>\<open> ------------------------ \<close>\<close>

\<comment> \<open>\<open> Shaked's addition, for which he is now forever responsible as a de facto
 * Lem maintainer...
 \<close>\<close>
\<comment> \<open>\<open>val bigintersection : forall 'a. SetType 'a => set (set 'a) -> set 'a\<close>\<close>
definition bigintersection  :: \<open>('a set)set \<Rightarrow> 'a set \<close>  where 
     \<open> bigintersection bs = ( (let x2 = 
  ({}) in  Finite_Set.fold
   ((\<lambda>x x2 . 
    if( \<forall> s \<in> bs. x \<in> s) then Set.insert x x2 else x2)) 
 x2 (\<Union> bs)))\<close> 
  for  "bs"  :: "('a set)set "


\<comment> \<open>\<open> ------------------------ \<close>\<close>
\<comment> \<open>\<open> difference               \<close>\<close>
\<comment> \<open>\<open> ------------------------ \<close>\<close>

\<comment> \<open>\<open>val differenceBy : forall 'a. ('a -> 'a -> ordering) -> set 'a -> set 'a -> set 'a\<close>\<close>
\<comment> \<open>\<open>val difference : forall 'a. SetType 'a => set 'a -> set 'a -> set 'a\<close>\<close>

\<comment> \<open>\<open> ------------------------ \<close>\<close>
\<comment> \<open>\<open> intersection             \<close>\<close>
\<comment> \<open>\<open> ------------------------ \<close>\<close>

\<comment> \<open>\<open>val intersection : forall 'a. SetType 'a => set 'a -> set 'a -> set 'a\<close>\<close>
\<comment> \<open>\<open>val intersectionBy : forall 'a. ('a -> 'a -> ordering) -> set 'a -> set 'a -> set 'a\<close>\<close>


\<comment> \<open>\<open> ------------------------ \<close>\<close>
\<comment> \<open>\<open> map                      \<close>\<close>
\<comment> \<open>\<open> ------------------------ \<close>\<close>

\<comment> \<open>\<open>val map : forall 'a 'b. SetType 'a, SetType 'b => ('a -> 'b) -> set 'a -> set 'b\<close>\<close> \<comment> \<open>\<open> before image \<close>\<close>
\<comment> \<open>\<open>let map f s=  { f e | forall (e IN s) | true }\<close>\<close>

\<comment> \<open>\<open>val mapBy : forall 'a 'b. ('b -> 'b -> ordering) -> ('a -> 'b) -> set 'a -> set 'b\<close>\<close> 


\<comment> \<open>\<open> ------------------------ \<close>\<close>
\<comment> \<open>\<open> bigunionMap              \<close>\<close>
\<comment> \<open>\<open> ------------------------ \<close>\<close>

\<comment> \<open>\<open> In order to avoid providing an comparison function for sets of sets,
   it might be better to combine bigunion and map sometimes into a single operation. \<close>\<close>

\<comment> \<open>\<open>val bigunionMap : forall 'a 'b. SetType 'a, SetType 'b => ('a -> set 'b) -> set 'a -> set 'b\<close>\<close>
\<comment> \<open>\<open>val bigunionMapBy : forall 'a 'b. ('b -> 'b -> ordering) -> ('a -> set 'b) -> set 'a -> set 'b\<close>\<close>

\<comment> \<open>\<open> ------------------------ \<close>\<close>
\<comment> \<open>\<open> mapMaybe and fromMaybe   \<close>\<close>
\<comment> \<open>\<open> ------------------------ \<close>\<close>

\<comment> \<open>\<open> If the mapping function returns Just x, x is added to the result
   set. If it returns Nothing, no element is added. \<close>\<close>

\<comment> \<open>\<open>val mapMaybe : forall 'a 'b. SetType 'a, SetType 'b => ('a -> maybe 'b) -> set 'a -> set 'b\<close>\<close>
definition setMapMaybe  :: \<open>('a \<Rightarrow> 'b option)\<Rightarrow> 'a set \<Rightarrow> 'b set \<close>  where 
     \<open> setMapMaybe f s = ( 
  \<Union> (Set.image ((\<lambda> x .  (case  f x of 
                          Some y  => {y} 
                        | None => {}
                        ))) s))\<close> 
  for  "f"  :: " 'a \<Rightarrow> 'b option " 
  and  "s"  :: " 'a set "


\<comment> \<open>\<open>val removeMaybe : forall 'a. SetType 'a => set (maybe 'a) -> set 'a\<close>\<close>
definition removeMaybe  :: \<open>('a option)set \<Rightarrow> 'a set \<close>  where 
     \<open> removeMaybe s = ( setMapMaybe ((\<lambda> x .  x)) s )\<close> 
  for  "s"  :: "('a option)set "


\<comment> \<open>\<open> ------------------------ \<close>\<close>
\<comment> \<open>\<open> min and max              \<close>\<close>
\<comment> \<open>\<open> ------------------------ \<close>\<close>

\<comment> \<open>\<open>val findMin : forall 'a.  SetType 'a, Eq 'a => set 'a -> maybe 'a\<close>\<close> 
\<comment> \<open>\<open>val findMax : forall 'a.  SetType 'a, Eq 'a => set 'a -> maybe 'a\<close>\<close>

\<comment> \<open>\<open> ------------------------ \<close>\<close>
\<comment> \<open>\<open> fromList                 \<close>\<close>
\<comment> \<open>\<open> ------------------------ \<close>\<close>

\<comment> \<open>\<open>val fromList : forall 'a.  SetType 'a => list 'a -> set 'a\<close>\<close> \<comment> \<open>\<open> before from_list \<close>\<close>
\<comment> \<open>\<open>val fromListBy : forall 'a.  ('a -> 'a -> ordering) -> list 'a -> set 'a\<close>\<close> 


\<comment> \<open>\<open> ------------------------ \<close>\<close>
\<comment> \<open>\<open> Sigma                    \<close>\<close>
\<comment> \<open>\<open> ------------------------ \<close>\<close>

\<comment> \<open>\<open>val sigma : forall 'a 'b. SetType 'a, SetType 'b => set 'a -> ('a -> set 'b) -> set ('a * 'b)\<close>\<close>
\<comment> \<open>\<open>val sigmaBy : forall 'a 'b. (('a * 'b) -> ('a * 'b) -> ordering) -> set 'a -> ('a -> set 'b) -> set ('a * 'b)\<close>\<close>

\<comment> \<open>\<open>let sigma sa sb=  { (a, b) | forall (a IN sa) (b IN sb a) | true }\<close>\<close>


\<comment> \<open>\<open> ------------------------ \<close>\<close>
\<comment> \<open>\<open> cross product            \<close>\<close>
\<comment> \<open>\<open> ------------------------ \<close>\<close>

\<comment> \<open>\<open>val cross : forall 'a 'b. SetType 'a, SetType 'b => set 'a -> set 'b -> set ('a * 'b)\<close>\<close>
\<comment> \<open>\<open>val crossBy : forall 'a 'b. (('a * 'b) -> ('a * 'b) -> ordering) -> set 'a -> set 'b -> set ('a * 'b)\<close>\<close>

\<comment> \<open>\<open>let cross s1 s2=  { (e1, e2) | forall (e1 IN s1) (e2 IN s2) | true }\<close>\<close>


\<comment> \<open>\<open> ------------------------ \<close>\<close>
\<comment> \<open>\<open> finite                   \<close>\<close>
\<comment> \<open>\<open> ------------------------ \<close>\<close>

\<comment> \<open>\<open>val finite : forall 'a. SetType 'a => set 'a -> bool\<close>\<close>


\<comment> \<open>\<open> ----------------------------\<close>\<close>
\<comment> \<open>\<open> fixed point                 \<close>\<close>
\<comment> \<open>\<open> --------------------------- \<close>\<close>

\<comment> \<open>\<open>val leastFixedPoint : forall 'a. SetType 'a 
  => nat -> (set 'a -> set 'a) -> set 'a -> set 'a\<close>\<close>
fun  leastFixedPoint  :: \<open> nat \<Rightarrow>('a set \<Rightarrow> 'a set)\<Rightarrow> 'a set \<Rightarrow> 'a set \<close>  where 
     \<open> leastFixedPoint 0 f x = ( x )\<close> 
  for  "f"  :: " 'a set \<Rightarrow> 'a set " 
  and  "x"  :: " 'a set "
|\<open> leastFixedPoint ((Suc bound')) f x = ( (let fx = (f x) in
                  if fx \<subseteq> x then x
                  else leastFixedPoint bound' f (fx \<union> x)))\<close> 
  for  "bound'"  :: " nat " 
  and  "f"  :: " 'a set \<Rightarrow> 'a set " 
  and  "x"  :: " 'a set "
 
end
