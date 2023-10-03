
type
  ExternalGenObj*[T] = object
    a*: T
  ExternalRefGenObj*[T] = ref object
    a*: T


proc externalGenProc1*[T](a:int=5) = discard
proc externalGenProc2*(a:int=5) = discard
