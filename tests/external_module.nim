
type
  ExternalGenObj*[T] = object
    a*: T
  ExternalRefGenObj*[T] = ref object
    a*: T


proc externalGenProc1*[T](a:int) = discard
