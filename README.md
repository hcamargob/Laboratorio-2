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
  Y en otro terminal se corre turtlesim
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
  
  
  
  
## RESULTADOS

## CONLCUSIONES
