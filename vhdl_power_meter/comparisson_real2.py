import math

print("running")

# uncomment lines below to generate signals
# r = 32
# freq = 60
# v = 0
# phase = math.pi/4
# for i in range(r):
#     v = (5*math.sin(2*math.pi*freq*(i/1000)+phase))
#     print(f"{v},", end="")
# print("")

voltage = [0,66,123,162,179,171,138,86,22,-44,-105,-151,-176,-176,-151,-105,-44,22,86,138,171,179,162,123,66,0,-66,-123,-162,-179,-171,-138]
current = [0,1,3,4,4,4,3,2,0,-1,-2,-4,-4,-4,-4,-2,-1,1,2,3,4,4,4,3,1,0,-1,-3,-4,-4,-4,-3] # -0
# current = [3,4,4,4,3,2,0,-1,-3,-4,-4,-4,-4,-2,-1,0,2,3,4,4,4,3,1,0,-1,-3,-4,-4,-4,-3,-2,0] # -math.pi/4 == 45 deg
current = [-3,-1,0,1,3,4,4,4,3,2,0,-1,-2,-4,-4,-4,-4,-3,-1,0,2,3,4,4,4,3,1,0,-1,-3,-4,-4] # -math.pi/4 == -45 deg
current = [-5,-4,-3,-2,0,1,3,4,4,4,4,2,0,0,-2,-4,-4,-4,-4,-3,-1,0,2,3,4,5,4,3,2,0,-1,-3] # -math.pi/2 == -90 deg

v_rms = 0
for i in voltage:
    v_rms += (i*i)
v_rms = math.sqrt((v_rms/len(voltage)))
print(f"voltage rms {v_rms}")

i_rms = 0
for i in current:
    i_rms += (i*i)    
i_rms = math.sqrt((i_rms/len(voltage)))
print(f"current rms {i_rms}")

temp = 0
ex = 0
aux = 0
t1 = 0
t2 = 0
for i in range(1, len(voltage)):
    if (ex == 1 or i==len(voltage)-1):
        break
    temp = voltage[i]
    if ((temp >= 0 and voltage[i+1] < 0) or (temp <= 0 and voltage[i+1] > 0)):        
        if (aux == 1):            
            ex = 1
            t2 = i           
        else:  
            t1 = i   
            aux = 1            
vcounter = t2#-t1
# print("t2=",t2," t1=",t1,"\n")

temp = 0
ex = 0
aux = 0
t1 = 0
t2 = 0
for i in range(1, len(current)):    
    if (ex == 1 or i==len(current)-1):
        break
    temp = current[i]
    if ((temp >= 0 and current[i+1] < 0) or (temp <= 0 and current[i+1] > 0)):
        if (aux == 1):
            ex = 1
            t2 = i                
        else:
            t1 = i
            aux = 1
icounter = t2#-t1
# print("t2=",t2," t1=",t1,"\n")

theta = (vcounter - icounter)*180/8.33
# print(f"theta * mod {theta}")
print(f"theta {theta}")

pf = abs(math.cos(theta*math.pi/180))
print(f"power factor {pf}")

apparent_power = (v_rms*i_rms)
print(f"apparent_power {apparent_power}")
real_power = (apparent_power*pf)
print(f"real_power {real_power}")
reactive_power = (apparent_power-real_power)
print(f"reactive_power {reactive_power}")