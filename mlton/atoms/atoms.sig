(* Copyright (C) 1999-2004 Henry Cejtin, Matthew Fluet, Suresh
 *    Jagannathan, and Stephen Weeks.
 * Copyright (C) 1997-1999 NEC Research Institute.
 *
 * MLton is released under the GNU General Public License (GPL).
 * Please see the file MLton-LICENSE for license information.
 *)
signature ATOMS_STRUCTS =
   sig
      structure Field: FIELD
      structure IntSize: INT_SIZE
      structure RealSize: REAL_SIZE
      structure Record: RECORD
      structure SortedRecord: RECORD
      structure Tyvar: TYVAR
      structure WordSize: WORD_SIZE
      sharing Field = Record.Field = SortedRecord.Field
   end

signature ATOMS' =
   sig
      include ATOMS_STRUCTS

      structure CFunction: C_FUNCTION
      structure CType: C_TYPE
      structure Con: CON
      structure Cons: SET
      structure Const: CONST
      structure Ffi: FFI
      structure Func: FUNC
      structure Label: LABEL
      structure Prim: PRIM
      structure ProfileLabel: PROFILE_LABEL
      structure ProfileExp: PROFILE_EXP
      structure RealX: REAL_X
      structure SourceInfo: SOURCE_INFO
      structure Tycon: TYCON
      structure Tycons: SET
      structure Var: VAR
      structure Vars: SET
      structure Tyvars: SET
      structure WordX: WORD_X

      sharing CFunction = Ffi.CFunction = Prim.CFunction
      sharing CType = Ffi.CType = Prim.CType 
      sharing Con = Prim.Con
      sharing Const = Prim.Const
      sharing IntSize = Tycon.IntSize
      sharing RealSize = Prim.RealSize = RealX.RealSize = Tycon.RealSize
      sharing RealX = Const.RealX
      sharing SourceInfo = ProfileExp.SourceInfo
      sharing WordSize = Prim.WordSize = Tycon.WordSize = WordX.WordSize
      sharing WordX = Const.WordX
   end

signature ATOMS =
   sig
      structure Atoms: ATOMS'
	 
      include ATOMS'

      (* For each structure, like CFunction, I would like to write two sharing
       * constraints
       *   sharing Atoms = CFunction
       *   sharing CFunction = Atoms.CFunction
       * but I can't because of a bug in SML/NJ that reports "Sharing structure
       * with a descendent substructure".  So, I am forced to write out lots
       * of individual sharing constraints.  Blech.
       *)
      sharing CFunction = Atoms.CFunction
      sharing CType = Atoms.CType
      sharing Con = Atoms.Con
      sharing Cons = Atoms.Cons
      sharing Const = Atoms.Const
      sharing Ffi = Atoms.Ffi
      sharing Field = Atoms.Field
      sharing Func = Atoms.Func
      sharing Label = Atoms.Label
      sharing Prim = Atoms.Prim
      sharing ProfileLabel = Atoms.ProfileLabel
      sharing ProfileExp = Atoms.ProfileExp
      sharing RealSize = Atoms.RealSize
      sharing RealX = Atoms.RealX
      sharing Record = Atoms.Record
      sharing SortedRecord = Atoms.SortedRecord
      sharing SourceInfo = Atoms.SourceInfo
      sharing Tycon = Atoms.Tycon
      sharing Tycons = Atoms.Tycons
      sharing Tyvar = Atoms.Tyvar
      sharing Tyvars = Atoms.Tyvars
      sharing Var = Atoms.Var
      sharing Vars = Atoms.Vars
      sharing WordSize = Atoms.WordSize
      sharing WordX = Atoms.WordX
   end
