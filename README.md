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
  
  *Insertar imagen de la tortuga movida hacia la derecha*
  
  Ahora para suscribirse al topic pose y ver la información de este se realiza el siguiente código:
  ```
  a=rossubscriber("/turtle1/pose","turtlesim/Pose");
  Pose=a.LatestMessage
  ```
  *Insertar imagen de solo workspace*
  
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
  *Insertar imagen de tortuga transportada (recorta para que se vea solo la ventana de turtlesim)*
  *Explicar funciones utilizadas (ver archivo texto importante en el git)
  
  El nodo maestro se finaliza usando el siuiente comando en Matlab:
  ```
  rosshutdown
  ```
  
## ANÁLISIS Y RESULTADOS

## CONLCUSIONES
