#!/usr/bin/env python
# coding: utf-8

# Keywords

# boolean true, false
log_var1 = (True == (1 > 2)) # False
log_var2 = (True == (2 > 1)) # True

# and, or, not
log_var3 = (True and True) # True
log_var4 = (True or False) # True
log_var5 = (not False) # True

# break, continue
while True:
    break    # ende
    continue # abbruch


# class
#class Coffee:
    # Define your class

# funktion
def say_hi():
    print("hi")


say_hi()

# if, elif, else
x = int(input("Eingabe Zahl: "))
if x > 3: print("Big")
elif x == 3: print("3")
else: print("Small")

# For 
for i in [0,1,2]:
    print(i)

# While 
j = 0
while j < 3:
    print(j); j = j + 1

# in
liste = [2, 39, 42]
log_var6 = 42 in liste # True
log_var6

# is
y = x = 3
log_var7 = x is y # True

# None
print() is None # True

# lambda
(lambda x: x+3)(2) # 5

# return
def increment(x):
    return x + 1


increment(4) # returns 5