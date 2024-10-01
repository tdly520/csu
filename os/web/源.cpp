#include <iostream>
#include <string>
#include <cstring>
#include <winsock2.h>
#include <ws2tcpip.h>
#include <windows.h>
#include <thread>
#include <fstream>

#pragma comment(lib, "Ws2_32.lib")

#define BUFFER_SIZE 1024
#define PORT 8080

void handle_request(SOCKET client_socket) {
    char buffer[BUFFER_SIZE];
    memset(buffer, 0, sizeof(buffer));
    recv(client_socket, buffer, sizeof(buffer), 0);

    // Parse HTTP request to get the filename
    std::string method, filename, protocol;
    std::istringstream request(buffer);
    request >> method >> filename >> protocol;

    // Remove leading '/'
    if (filename.size() > 1 && filename[0] == '/') {
        filename = filename.substr(1);
    }

    // Only handle GET requests
    if (method != "GET") {
        std::string error_message = "HTTP/1.1 405 Method Not Allowed\r\nContent-Type: text/html\r\n\r\n<h1>405 Method Not Allowed</h1>";
        send(client_socket, error_message.c_str(), error_message.size(), 0);
        closesocket(client_socket);
        return;
    }

    // Check file extension
    size_t dot_pos = filename.find_last_of('.');
    if (dot_pos != std::string::npos) {
        std::string file_extension = filename.substr(dot_pos);

        if (file_extension == ".html") {
            std::ifstream file(filename, std::ios::binary);
            if (file.is_open()) {
                std::string response_header = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n";
                send(client_socket, response_header.c_str(), response_header.size(), 0);

                while (!file.eof()) {
                    file.read(buffer, sizeof(buffer));
                    send(client_socket, buffer, file.gcount(), 0);
                }
                file.close();
                closesocket(client_socket);
                return;
            }
        }
        else {
            std::ifstream file(filename, std::ios::binary);
            if (file.is_open()) {
                std::string response_header = "HTTP/1.1 200 OK\r\nContent-Type: application/octet-stream\r\nContent-Disposition: attachment; filename=\"" + filename + "\"\r\n\r\n";
                send(client_socket, response_header.c_str(), response_header.size(), 0);

                while (!file.eof()) {
                    file.read(buffer, sizeof(buffer));
                    send(client_socket, buffer, file.gcount(), 0);
                }
                file.close();
                closesocket(client_socket);
                return;
            }
        }
    }

    // File does not exist or filename extension is unsupported, return 404 error
    std::string error_message = "HTTP/1.1 404 Not Found\r\nContent-Type: text/html\r\n\r\n<h1>404 Not Found</h1>";
    send(client_socket, error_message.c_str(), error_message.size(), 0);
    closesocket(client_socket);
}

void handle_client(SOCKET client_socket) {
    std::thread client_thread(handle_request, client_socket);
    client_thread.detach();
}

int main() {
    WSADATA wsaData;
    int iResult;

    SOCKET server_socket, client_socket;
    struct sockaddr_in server_addr, client_addr;
    int addr_size = sizeof(client_addr);

    // Initialize Winsock
    iResult = WSAStartup(MAKEWORD(2, 2), &wsaData);
    if (iResult != 0) {
        std::cerr << "WSAStartup failed: " << iResult << std::endl;
        return 1;
    }

    // Create socket
    server_socket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    if (server_socket == INVALID_SOCKET) {
        std::cerr << "Socket failed: " << WSAGetLastError() << std::endl;
        WSACleanup();
        return 1;
    }

    // Configure server address
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = INADDR_ANY;
    server_addr.sin_port = htons(PORT);

    // Bind address and port
    if (bind(server_socket, (struct sockaddr*)&server_addr, sizeof(server_addr)) == SOCKET_ERROR) {
        std::cerr << "Bind failed: " << WSAGetLastError() << std::endl;
        closesocket(server_socket);
        WSACleanup();
        return 1;
    }

    // Start listening for connections
    if (listen(server_socket, 5) == SOCKET_ERROR) {
        std::cerr << "Listen failed: " << WSAGetLastError() << std::endl;
        closesocket(server_socket);
        WSACleanup();
        return 1;
    }
    std::cout << "Server listening on port " << PORT << "..." << std::endl;

    while (true) {
        // Accept connection request
        client_socket = accept(server_socket, (struct sockaddr*)&client_addr, &addr_size);
        if (client_socket == INVALID_SOCKET) {
            std::cerr << "Accept failed: " << WSAGetLastError() << std::endl;
            continue;
        }
        std::cout << "Connection accepted from " << inet_ntoa(client_addr.sin_addr) << ":" << ntohs(client_addr.sin_port) << std::endl;

        // Handle request in a separate thread
        handle_client(client_socket);
    }

    closesocket(server_socket);
    WSACleanup();
    return 0;
}
