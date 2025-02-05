from dataclasses import dataclass
from typing import Optional

from utils.error import Error


@dataclass
class Result[T]:
    success: bool
    value: Optional[T] = None
    error: Optional[Error] = None

    def __bool__(self):
        return self.success

    def unwrap(self):
        if self.success:
            return self.value
        else:
            raise self.error
