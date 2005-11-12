/* Copyright (C) 1999-2005 Henry Cejtin, Matthew Fluet, Suresh
 *    Jagannathan, and Stephen Weeks.
 * Copyright (C) 1997-2000 NEC Research Institute.
 *
 * MLton is released under a BSD-style license.
 * See the file MLton-LICENSE for details.
 */

size_t sizeofWeak (GC_state s) {
  size_t res;

  res = GC_NORMAL_HEADER_SIZE + sizeof (struct GC_weak);
  res = align (res, s->alignment);
  if (DEBUG) {
    size_t check;
    uint16_t numNonObjptrs, numObjptrs;

    splitHeader (s, GC_WEAK_GONE_HEADER, NULL, NULL, &numNonObjptrs, &numObjptrs);
    check = GC_NORMAL_HEADER_SIZE + sizeofWeakNoHeader (s, numNonObjptrs, numObjptrs);
    assert (check == res);
  }
  assert (isAligned (res, s->alignment));
  return res;
}

size_t offsetofWeak (GC_state s) {
  return (sizeofWeak (s)) - (GC_NORMAL_HEADER_SIZE + sizeof (struct GC_weak));
}

uint32_t GC_weakCanGet (__attribute__ ((unused)) GC_state s, pointer p) {
  uint32_t res;

  res = GC_WEAK_GONE_HEADER != getHeader (p);
  if (DEBUG_WEAK)
    fprintf (stderr, "%s = GC_weakCanGet ("FMTPTR")\n",
             boolToString (res), (uintptr_t)p);
  return res;
}

pointer GC_weakGet (GC_state s, pointer p) {
  GC_weak weak;
  pointer res;

  weak = (GC_weak)(p + (offsetofWeak (s)));
  res = objptrToPointer(weak->objptr, s->heap.start);
  if (DEBUG_WEAK)
    fprintf (stderr, FMTPTR" = GC_weakGet ("FMTPTR")\n",
             (uintptr_t)res, (uintptr_t)p);
  return res;
}

pointer GC_weakNew (GC_state s, GC_header header, pointer p) {
  GC_weak weak;
  pointer res;

  res = newObject (s, header, 
                   sizeofWeak (s),
                   FALSE);
  weak = (GC_weak)(res + (offsetofWeak (s)));
  weak->objptr = pointerToObjptr(p, s->heap.start);
  if (DEBUG_WEAK)
    fprintf (stderr, FMTPTR" = GC_weakNew ("FMTHDR", "FMTPTR")\n",
             (uintptr_t)res, header, (uintptr_t)p);
  return (pointer)res;
}
