%%
rosinit; %Conexión con nodo maestro
%%
velPub = rospublisher('/turtle1/cmd_vel','geometry_msgs/Twist'); %Creación publicador
velMsg = rosmessage(velPub); %Creación de mensaje
%%
velMsg.Linear.X = 0; %Valor del mensaje
send(velPub,velMsg); %Envio
pause(1)
%%
a=rossubscriber("/turtle1/pose","turtlesim/Pose");
Pose=a.LatestMessage
%%
Client = rossvcclient('/turtle1/teleport_absolute');
msg=rosmessage(Client);
msg.X=8;
msg.Y=5;
msg.Theta=0;
call(Client,msg);
pause(1)
%%
rosshutdown


