# Laboratorio 2: - Robótica de Desarrollo, Intro a ROS

<p align="center">
ROBÓTICA

<p align="center">
Hugo Alejandro Camargo Barrera
<p align="center">
email: hcamargob@unal.edu.co

<p align="center">
Santiago Hernández Lamprea
<p align="center">
email: shernandezl@unal.edu.co


<p align="center">
INGENIERÍA MECATRÓNICA
<p align="center">
Facultad de Ingeniería
<p align="center">
Universidad Nacional de Colombia Sede Bogotá

  
## METODOLOGÍA
### Conexión de ROS con Matlab
  
  Se abre un terminal para correr el nodo maestro:
  ```
  roscore
  ```
  Y en otro terminal se corre turtlesim:
  ```
  rosrun turtlesim turtlesim_node
  ```
  Se abre Matlab y se agrega el siguiente código a un script:
  ```
  %%
  rosinit; %Conexión con nodo maestro
  %%
  velPub = rospublisher(’/turtle1/cmd_vel’,’geometry_msgs/Twist’); %Creación publicador
  velMsg = rosmessage(velPub); %Creación de mensaje
  %%
  velMsg.Linear.X = 1; %Valor del mensaje
  send(velPub,velMsg); %Envio
  pause(1)
  ```
![image](https://user-images.githubusercontent.com/112737454/191142753-adc60d73-4629-47cb-9581-482967ecd7ca.png)
  
  Ahora para suscribirse al topic pose y ver la información de este se realiza el siguiente código:
  ```
  a=rossubscriber("/turtle1/pose","turtlesim/Pose");
  Pose=a.LatestMessage
  ```
![image](https://user-images.githubusercontent.com/112737454/191142674-48eeb2b1-08ac-4641-83f8-4014e3871376.png)

  
  Cabe aclarar que el comando *rossubscriber* solo se debe ejecutar una vez ya que no es posible suscribirse dos veces a un nodo, entonces solo se debería ejecutar la primera línea una vez y la segunda cada vez que se quiera saber la información de la pose.
 
  El siguiente código de matlab permite enviar todos los valores asociados a la pose de turtle1:
  ```
  Client = rossvcclient('/turtle1/teleport_absolute');
  msg=rosmessage(Client);
  msg.X=8;
  msg.Y=5;
  msg.Theta=2;
  call(Client,msg);
  pause(1)
  ```

  ![image](https://user-images.githubusercontent.com/112737454/191140466-a16614ba-a854-49d7-ba1e-ba527bece21b.png)
  
  *Explicar funciones utilizadas (ver archivo texto importante en el git)
  
  El nodo maestro se finaliza usando el siuiente comando en Matlab:
  ```
  rosshutdown
  ```
  
### ROS usando Python
  
Se importaron las librerías necesarias para la ejecución del programa.
  ``` 
import rospy
import numpy as np
from geometry_msgs.msg import Twist 
import termios, sys, os
from turtlesim.srv import TeleportAbsolute
from turtlesim.srv import TeleportRelative
TERMIOS = termios
  ```
  Se agrega la siguiente función. Esta recibe las teclas pulsadas en la terminal de Visual Studio, las interpreta y posteriormente realiza una acción.
  ``` 
def getkey():
    fd = sys.stdin.fileno()
    old = termios.tcgetattr(fd)
    new = termios.tcgetattr(fd)
    new[3] = new[3] & ~TERMIOS.ICANON & ~TERMIOS.ECHO
    new[6][TERMIOS.VMIN] = 1
    new[6][TERMIOS.VTIME] = 0
    termios.tcsetattr(fd, TERMIOS.TCSANOW, new)
    c = None
    try:
        c = os.read(fd, 1)
    finally:
        termios.tcsetattr(fd, TERMIOS.TCSAFLUSH, old)
    return c
  ```
  
## ANÁLISIS Y RESULTADOS

## CONLCUSIONES
