
import Location_pb2

import socket

import time


socket_server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

socket_server.bind(('localhost', 1234))
socket_server.listen(5)

while True:
    conn, addr = socket_server.accept()

    data = conn.recv(1024)

    print(data)
    
    if data == bytes('PING', encoding='utf-8'):
        conn.send(bytes("PONG", encoding='utf-8'))
    
    else:
        location = Location_pb2.Location()
        location.ParseFromString(data)

        print(location.accessToken)

        conn.send(data)

    conn.close()