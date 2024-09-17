import random

# Soldier
#test command:  python3 4-testsWar.py --v

class Soldier:
    
    def __init__(self, health, strength):
        # your code here
        self.health=health
        self.strength=strength
    
    def attack(self):
        #print(f"Atacando... \nFuerza para ataque: {self.strength}")
        return self.strength

    def receiveDamage(self, damage):
        # your code here
        self.health-=damage
        #print(f"Daño recibido: {damage}")
        #print(f"Salud: {self.health}")

# Viking

class Viking(Soldier):
    def __init__(self, name, health, strength):
        # your code here
        self.name=name
        self.health=health
        self.strength=strength

    def battleCry(self):
        # your code here
        return "Odin Owns You All!"
        
    def receiveDamage(self, damage):
        # your code here
        self.health-=damage
        if self.health>0:
            return f"{self.name} has received {damage} points of damage"
        else:
            return f"{self.name} has died in act of combat"

# Saxon

class Saxon(Soldier):
    def __init__(self, health, strength):
        # your code here
        self.health=health
        self.strength=strength

    def receiveDamage(self, damage):
        # your code here
        self.health-=damage
        if self.health>0:
            return f"A Saxon has received {damage} points of damage"
        else:
            return f"A Saxon has died in combat"

# Davicente

class War():
    def __init__(self):
        # your code here
        self.vikingArmy=[]
        self.saxonArmy=[]
    
    def addViking(self, viking):
        # your code here
        self.vikingArmy.append(viking)
        
    def addSaxon(self, saxon):
        # your code here
        self.saxonArmy.append(saxon)
        
    def vikingAttack(self):
        # your code here
        if self.vikingArmy!=[] and self.saxonArmy!=[]:
            if len(self.vikingArmy)>1:
                pos_random_viking=random.randrange(0,len(self.vikingArmy))
            else:
                pos_random_viking=0

            if len(self.saxonArmy)>1:
                pos_random_saxon=random.randrange(0,len(self.saxonArmy))
            else:
                pos_random_saxon=0
                
            strength_viking=self.vikingArmy[pos_random_viking].strength
            reciveDamage_result=self.saxonArmy[pos_random_saxon].receiveDamage(strength_viking)

            if self.saxonArmy[pos_random_saxon].health>0:
                pass
            else:
               self.saxonArmy.pop(pos_random_saxon)
                
            return reciveDamage_result
            
        else:
            pass
        
    def saxonAttack(self):
        # your code here
        if self.vikingArmy!=[] and self.saxonArmy!=[]:
            if len(self.vikingArmy)>1:
                pos_random_viking=random.randrange(0,len(self.vikingArmy))
            else:
                pos_random_viking=0

            if len(self.saxonArmy)>1:
                pos_random_saxon=random.randrange(0,len(self.saxonArmy))
            else:
                pos_random_saxon=0
                
            strength_saxon=self.saxonArmy[pos_random_saxon].strength
            reciveDamage_result=self.vikingArmy[pos_random_viking].receiveDamage(strength_saxon)

            if self.vikingArmy[pos_random_viking].health>0:
                pass
            else:
               self.vikingArmy.pop(pos_random_viking)
                
            return reciveDamage_result
            
        else:
            pass
            
    def showStatus(self):
        # your code here
        if self.saxonArmy==[]:
            return "Vikings have won the war of the century!"
        elif self.vikingArmy==[]:
            return "Saxons have fought for their lives and survive another day..."
        else:
            return "Vikings and Saxons are still in the thick of battle."
            
    #pass

# #yop
# class War2:

#     def __init__(self):
#         # your code here

#     def addViking(self, Viking):
#         # your code here
    
#     def addSaxon(self, Saxon):
#         # your code here
    
#     def vikingAttack(self):
#         # your code here

#     def saxonAttack(self):
#         # your code here

#     def showStatus(self):
#         # your code here

#     pass


