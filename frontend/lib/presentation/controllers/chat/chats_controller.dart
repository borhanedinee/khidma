import 'package:get/get.dart';
import 'package:khidma/constatnts/constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService extends GetxController {
  late IO.Socket _socket;

  bool isConnected = false;
  List receivedMessages = <String>[];

  Future<void> connect() async {
    _socket = IO.io(
      BASE_URL, // Replace with your backend URL
      IO.OptionBuilder()
          .setQuery({'userId': '12345'})
          .setTransports(['websocket']) // Specify WebSocket transport
          .disableAutoConnect() // Prevent auto-connection
          .build(),
    );

    // Connection established
    _socket.onConnect((_) {
      isConnected = true;
      print("Connected to Socket.IO");
    });

    // Listen for messages
    _socket.on('message', (data) {
      print("Message received: $data");
      receivedMessages.add(data); // Add the message to the list
    });

    // Handle disconnection
    _socket.onDisconnect((_) {
      isConnected = false;
      print("Disconnected from Socket.IO");
    });

    // Connect to the server
    _socket.connect();
  }


  void sendMessage(String message) {
    if (isConnected) {
      _socket.emit('message', message);
      print("Message sent: $message");
    } else {
      print("Cannot send message. Not connected to Socket.IO.");
    }
  }

  void disconnect() {
    if (isConnected) {
      _socket.disconnect();
      isConnected = false;
      print("Disconnected from Socket.IO");
    }
  }

  @override
  void onClose() {
    disconnect();
    super.onClose();
  }
}
