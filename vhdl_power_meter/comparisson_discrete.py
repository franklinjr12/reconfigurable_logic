import math
from math import factorial as fac
import time
import numpy

def mysin(x):
    if (x > 50):        
        return 150-x
    if (x > 0):
        return (-x*25)/100+100
    if (x > -50):
        return (x*25)/100+100
    return x+150

def mysqrt(x):
    if (x == 0):
        return 0
    mod = 1#(2**16)
    y = 1
    x2 = int(x*mod)
    for i in range(10): 
        if (y == 0):
            return 0
        y = int((y+x2/y)/(2))
        # print(y)
    return int(y/mod)

# print(mysqrt(3600))

print("running")
r = 32
v = 0
for i in range(r):
    # print(f"{v},", end="")
    v = int(5*math.sin(2*math.pi*60*i/1000))

v = [0,0,67,124,163,180,172,139,87,23,10,1,-151,-176,-176,-151,-105,-44,23,87,139,172,180,163,124,67,1,-66,-123,-162,-179,-171]
v = [0,0,1,3,4,4,4,3,2,0,-1,-2,-4,-4,-4,-4,-2,-1,0,2,3,4,4,4,3,1,0,-1,-3,-4,-4,-4]
v_scaled = []
for i in v:
    v_scaled.append(i*(2**16))
    # v_scaled.append(i)
# print(f"\n{v_scaled}")

v_rms = 0
# v2 = 0
v = [0,0,67,124,163,180,172,139,87,23,10,1,-151,-176,-176,-151,-105,-44,23,87,139,172,180,163,124,67,1,-66,-123,-162,-179,-171]
for i in v:
    v_rms += (i*i)
    # v2 += (i*i)
v_rms /= r
# v2 /= r
# v_rms = math.sqrt(v_rms)
v_rms = mysqrt(v_rms)
# v2 = mysqrt(v2)
print(f"voltage rms {v_rms}")
# print(v2)

i_rms = 0
v = [0,0,1,3,4,4,4,3,2,0,-1,-2,-4,-4,-4,-4,-2,-1,0,2,3,4,4,4,3,1,0,-1,-3,-4,-4,-4]
for i in v:
    i_rms += (i*i)    
i_rms /= r
i_rms = mysqrt(i_rms)
print(f"current rms {i_rms}")

v = [0,0,67,124,163,180,172,139,87,23,10,1,-151,-176,-176,-151,-105,-44,23,87,139,172,180,163,124,67,1,-66,-123,-162,-179,-171]
counter = 0
temp = 0
ex = 0
aux = 0
for i in range(1, len(v)):    
    # print(f"[{v[i]}] ", end="")
    if (ex == 1 or i==(len(v)-1)):
        break
    temp = v[i]
    if ((temp >= 0 and v[i+1] < 0) or (temp <= 0 and v[i+1] > 0)):
        if (aux == 1):
            ex = 1
        else:                
            aux = 1            
    counter += 1
# print("\n")
# print(counter)
vcounter = counter

v = [0,0,1,3,4,4,4,3,2,0,-1,-2,-4,-4,-4,-4,-2,-1,0,2,3,4,4,4,3,1,0,-1,-3,-4,-4,-4]
counter = 0
temp = 0
ex = 0
aux = 0
for i in range(1, len(v)):    
    # print(f"[{v[i]}] ", end="")
    if (ex == 1 or i==(len(v)-1)):
        break
    temp = v[i]
    if ((temp >= 0 and v[i+1] < 0) or (temp <= 0 and v[i+1] > 0)):
        if (aux == 1):
            ex = 1
        else:                
            aux = 1
    counter += 1
# print("\n")
# print(counter)

mod = 2**16

theta = (int(int(
                (vcounter - counter)*100*mod)
                /(833))
                )*180
print(f"theta * mod {theta}")
theta = int(theta/mod)
print(f"theta {theta}")

pf = mysin(theta)
print(f"power factor {pf}")

apparent_power = int(v_rms*i_rms)
print(f"apparent_power {apparent_power}")
real_power = int(apparent_power*pf/100)
print(f"real_power {real_power}")
reactive_power = int(apparent_power*(100-pf)/100)
print(f"reactive_power {reactive_power}")


# print(math.cos(1))
# print(math.cos(1+2*math.pi*10))

# print("")
# a = 0.8
# for i in numpy.arange(-1,1,0.2):
#     print(f"{mysin(i)} {math.cos(i)}")
# print(mysin(a))
# print(math.cos(a))

# r = 32
# v = 0
# a = 0
# for i in range(10):
#     print(f"{a} ", end="")
#     a = math.pi*10*i/2
#     v = math.sin(a)
