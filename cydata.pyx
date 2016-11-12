from libcpp.set cimport set
from libcpp.map cimport map
from libcpp.string cimport string

cdef class intset:
     cdef public set[int] values

     def add(self, val):
         self.values.insert(val)

     def __iter__(self):
         return iter(self.values)

     def __getstate__(self):
         return list(self.values)

     def __setstate__(self, x):
         for k in x:
            self.values.insert(k)

cdef class string_int_map:
     cdef public map[string, int] values

     def __setitem__(self, k, v):
         self.values[<bytes>k] = v

     def get(self, k):
         return self.values.get(<bytes>k)

cdef class int_string_map:
     cdef public map[int, string] values

     def __setitem__(self, k, v):
         self.values[k] = v.encode('utf8')

     def get(self, k):
         return self.values.get(k)

cdef class int_int_map:
     cdef public map[long, long] _values

     def __getitem__(self, k):
         return self._values[k]

     def __setitem__(self, k, v):
         self._values[k] = v

     def get(self, k):
         return self._values.get(k)

     def __len__(self):
         return len(self._values)

     def __iter__(self):
         for k in self._values.keys():
             yield k

     def items(self):
         for k, v in self._values.items():
             yield k, v

     def values(self):
         for v in self._values.values():
             yield v

     def __contains__(self, k):
         return self._values.count(k)

     def __getstate__(self):
         return list(self.items())

     def __setstate__(self, x):
         for k, v in x:
             self[k] = v

cdef class int_intset_map:
     cdef public map[long, set[int]] _values

     def __getitem__(self, k):
         return self._values[k]

     def __setitem__(self, k, v):
         self._values[k] = v

     def get(self, k):
         return self._values.get(k)

     def __len__(self):
         return len(self._values)

     def __iter__(self):
         for k in self._values.keys():
             yield k

     def items(self):
         for k, v in self._values.items():
             yield k, v

     def values(self):
         for v in self._values.values():
             yield v

     def __contains__(self, k):
         return self._values.count(k)
