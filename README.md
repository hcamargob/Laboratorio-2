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
  
  
  El nodo maestro se finaliza usando el siuiente comando en Matlab:
  ```
  rosshutdown
  ```
  
### ROS usando Python
  
Se importan las librerías necesarias para la ejecución del programa.
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
  Se hace la conexión con el servicio _teleport\_absolute_, y se le asigna a la tecla R
  ```
  def teleport(x, y, ang):
   rospy.wait_for_service('/turtle1/teleport_absolute')
   try:
       teleportA = rospy.ServiceProxy('/turtle1/teleport_absolute', TeleportAbsolute)
       resp1 = teleportA(x, y, ang)
       print('Teleported to x: {}, y: {}, ang: {}'.format(str(x),str(y),str(ang)))
   except rospy.ServiceException as e:
       print(str(e))
  ```
  Luego, se hace a conexión con el servicio _teleport\_relative_, y se le asigna a la tecla ESPACIO
  
  ```
  def teleportRel(x,ang):
   rospy.wait_for_service('/turtle1/teleport_relative')
   try:
       teleportR = rospy.ServiceProxy('/turtle1/teleport_relative', TeleportRelative)
       resp1 = teleportR(x, ang)
       
   except rospy.ServiceException:
       pass
  ```
  
 Posteriormente, se usa el tópico _cmd\_vel_ para asignar las funciones de las teclas W, A, S y D.
  
  ```
  def pubVel(vel_x, ang_z, t):
   pub = rospy.Publisher('/turtle1/cmd_vel', Twist, queue_size=10)
   rospy.init_node('velPub', anonymous=False)
   vel = Twist()
   vel.linear.x = vel_x
   vel.angular.z = ang_z
   #rospy.loginfo(vel)
   endTime = rospy.Time.now() + rospy.Duration(t)
   while rospy.Time.now() < endTime:
       pub.publish(vel)

if __name__ == '__main__':
   pubVel(0,0,0.1)
   try:
       while(1):
           Tec=getkey()
           if Tec==b'w':
               pubVel(0.5,0,0.01)
           if Tec==b'a':
               pubVel(0,0.5,0.01)
           if Tec==b's':
               pubVel(-0.5,0,0.01)
           if Tec==b'd':
               pubVel(0,-0.5,0.01)
           if Tec==b' ':
               teleportRel(0,np.pi)
           if Tec==b'r':
               teleport(5.544445,5.544445,0)
           if Tec==b'\x1b':
               break                    
           

   except rospy.ROSInterruptException:
       pass
  ```
Finalmente, se incluye el script realizado (myTeleopKey.py) al artchivo CMakeLists.txt. Después, se ingresa el comando catkin build en una nueva terminal para guardar los cambios ejecutados y se realiza las pruebas del código ejecutando Turtlesim, corriendo el archivo creado con el comando _rosrun hello\_turtle myTeleopKey.py._
                                    
## ANÁLISIS Y RESULTADOS
### Matlab
## CONLCUSIONES
