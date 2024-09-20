print("#1. Importa el paquete NUMPY bajo el nombre np.")
#1. Importa el paquete NUMPY bajo el nombre np.

#[tu código aquí]
import numpy as np


print("#2. Imprime la versión de NUMPY y la configuración.")
#2. Imprime la versión de NUMPY y la configuración.

#[tu código aquí]
print("NumPy version:", np.__version__)

# Mostrar configuración
np.show_config()

print("#3. Genera un array tridimensional de 2x3x5 con valores aleatorios. Asigna el array a la variable 'a'")
#3. Genera un array tridimensional de 2x3x5 con valores aleatorios. Asigna el array a la variable "a"
# Desafío: hay al menos tres maneras fáciles que usan numpy para generar arrays aleatorios. ¿Cuántas formas puedes encontrar?

#[tu código aquí]
a = np.random.randint(100, size=(2, 3, 5)) # (block, rows, columns)
a = np.random.rand(2, 3, 5)
a = np.random.randn(2, 3, 5) #distribución normal

print("#4. Imprime a.")
#4. Imprime a.

#[tu código aquí]
print(a)

print("#5. Crea un array tridimensional de 5x2x3 con todos los valores igual a 1.")
#5. Crea un array tridimensional de 5x2x3 con todos los valores igual a 1.
#Asigna el array a la variable "b"

#[tu código aquí]
b = np.ones((5, 2, 3))

print("#6. Imprime b.")
#6. Imprime b.

#[tu código aquí]
print(b)

print("#7. ¿Tienen a y b el mismo tamaño? ¿Cómo lo demuestras en código Python?")
#7. ¿Tienen a y b el mismo tamaño? ¿Cómo lo demuestras en código Python?

#[tu código aquí]
print("Same size?",a.size==b.size)

print("#8. ¿Es posible sumar a y b? ¿Por qué sí o por qué no?")
#8. ¿Es posible sumar a y b? ¿Por qué sí o por qué no?

#[tu código aquí]
try:
    print(a+b)
except:
    print("Sí es posible sumar tensores si tienen la misma forma o si sus formas son compatibles mediante broadcasting. No es posible si sus formas son completamente incompatibles.")

print("#9. Transpone b para que tenga la misma estructura que a")
#9. Transpone b para que tenga la misma estructura que a (es decir, se convierta en un array de 2x3x5). Asigna el array transpuesto a la variable "c".

#[tu código aquí]

c=np.transpose(b,axes=(1,2,0))
print("The c shape is:", c.shape)
print("The b shape is:", b.shape)
print("The a shape is:", a.shape)

print("#10. Intenta sumar a y c. Ahora debería funcionar. Asigna la suma a la variable 'd'. Pero, ¿por qué funciona ahora?")
#10. Intenta sumar a y c. Ahora debería funcionar. Asigna la suma a la variable "d". Pero, ¿por qué funciona ahora?

#[tu código aquí]
d=a+c
print("a+c=",d)

print("#11. Imprime a y d. ¿Notas la diferencia y la relación entre los dos arrays en términos de los valores? Explica.")
#11. Imprime a y d. ¿Notas la diferencia y la relación entre los dos arrays en términos de los valores? Explica.

#[tu código aquí]

print("a=",a)
print("d=",d)
print("Identifico que se corresponde en forma y tamaño, también en el tipo de los valores, tratándose de floats.")

print("#12. Multiplica a y c. Asigna el resultado a e.")
#12. Multiplica a y c. Asigna el resultado a e.

#[tu código aquí]
e=a*c
print("e=",e)

print("#13. ¿Es e igual a a? ¿Por qué sí o por qué no?")
#13. ¿Es e igual a a? ¿Por qué sí o por qué no?

#[tu código aquí]
print(c)
print("e==a:",e==a)
print("Sí son iguales debido a la propiedad de las matrices en la multiplicación de c por a ya que c es una matriz de 1'os.")

print("#14. Identifica los valores máximos, mínimos y medios en d.")
#14. Identifica los valores máximos, mínimos y medios en d. Asigna esos valores a las variables "d_max", "d_min" y "d_mean"

#[tu código aquí]
d_max=np.max(d)
d_min=np.min(d)
d_mean=np.mean(d)

print("d_max=",np.max(d))
print("d_min=",np.min(d))
print("d_mean=",np.mean(d))

print("15. Ahora queremos etiquetar los valores en d. Primero crea un array vacío 'f'")
#15. Ahora queremos etiquetar los valores en d. Primero crea un array vacío "f" con la misma forma (es decir, 2x3x5) que d usando `np.empty`.

#[tu código aquí]
f=np.empty((2,3,5))

print("#16. Rellena los valores en f. Para cada valor en d")
"""
#16. Rellena los valores en f. Para cada valor en d, si es mayor que d_min pero menor que d_mean, asigna 25 al valor correspondiente en f.
Si un valor en d es mayor que d_mean pero menor que d_max, asigna 75 al valor correspondiente en f.
Si un valor es igual a d_mean, asigna 50 al valor correspondiente en f.
Asigna 0 al valor correspondiente(s) en f para d_min en d.
Asigna 100 al valor correspondiente(s) en f para d_max en d.
Al final, f debería tener solo los siguientes valores: 0, 25, 50, 75 y 100.
Nota: no necesitas usar Numpy en esta pregunta.
"""


#[tu código aquí]
f[(d_min<d) & (d<d_mean)] = 25
f[(d<d_max) & (d>d_mean)] = 75
f[d==d_mean] = 50
f[d==d_min] = 0
f[d==d_max] = 100

print("#17. Imprime d y f. ¿Tienes el f esperado?")
"""
#17. Imprime d y f. ¿Tienes el f esperado?
Por ejemplo, si tu d es:
array([[[1.85836099, 1.67064465, 1.62576044, 1.40243961, 1.88454931],
        [1.75354326, 1.69403643, 1.36729252, 1.61415071, 1.12104981],
        [1.72201435, 1.1862918 , 1.87078449, 1.7726778 , 1.88180042]],

       [[1.44747908, 1.31673383, 1.02000951, 1.52218947, 1.97066381],
        [1.79129243, 1.74983003, 1.96028037, 1.85166831, 1.65450881],
        [1.18068344, 1.9587381 , 1.00656599, 1.93402165, 1.73514584]]])

Tu f debería ser:
array([[[ 75.,  75.,  75.,  25.,  75.],
        [ 75.,  75.,  25.,  25.,  25.],
        [ 75.,  25.,  75.,  75.,  75.]],

       [[ 25.,  25.,  25.,  25., 100.],
        [ 75.,  75.,  75.,  75.,  75.],
        [ 25.,  75.,   0.,  75.,  75.]]])
"""

#[tu código aquí]
print("d=",d)
print("f=",f)

print("18. Pregunta de bonificación:")

"""
#18. Pregunta de bonificación: en lugar de usar números (es decir, 0, 25, 50, 75 y 100), ¿cómo usar valores de cadena 
("A", "B", "C", "D" y "E") para etiquetar los elementos del array? Esperas el resultado sea:
array([[[ 'D',  'D',  'D',  'B',  'D'],
        [ 'D',  'D',  'B',  'B',  'B'],
        [ 'D',  'B',  'D',  'D',  'D']],

       [[ 'B',  'B',  'B',  'B',  'E'],
        [ 'D',  'D',  'D',  'D',  'D'],
        [ 'B',  'D',   'A',  'D', 'D']]])
De nuevo, no necesitas Numpy en esta pregunta.
"""

#[tu código aquí]
def etiquetar(valor):
    if valor == 0:
        return 'A'
    elif valor == 25:
        return 'B'
    elif valor == 50:
        return 'C'
    elif valor == 75:
        return 'D'
    else:
        return 'E'
        
#np.vectorize(): Convierte la función para que pueda aplicarse a cada elemento de la matriz.
f=np.vectorize(etiquetar)(f)
print(f)
