import datetime
import math

class Person: 
    def __init__(self, name: str, lastname: str, birthday: datetime.date):
        self.birthday = birthday
        self.lastname = lastname
        self.name     = name
    
    @property
    def age(self) -> int: 
        return math.floor((datetime.date.today() - self.birthday).days / 365.2425)

    def __str__(self) -> str:
        return f"{self.name} {self.lastname} has {self.age} years"


jess = Person(name='Jessica',lastname='Silva',birthday=datetime.date(1997,3,10))


print(jess)
print(jess.name)
print(jess.lastname)
print(jess.birthday)
print(jess.age)