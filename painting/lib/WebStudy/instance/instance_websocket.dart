//单例：饿汉模式，加载的时候就初始化
import 'package:web_socket_channel/io.dart';

class WebsocketInstance {
  IOWebSocketChannel channel;

  // 单例公开访问点
  factory WebsocketInstance() => _websocketInstance();

  // 静态私有成员，没有初始化
  static WebsocketInstance _instance = WebsocketInstance._();

  // 私有构造函数
  WebsocketInstance._() {
    // 具体初始化代码
    channel = new IOWebSocketChannel.connect(
        'ws://49.234.76.105:80/chatroom/1/listen');
  }

  // 静态、同步、私有访问点
  static WebsocketInstance _websocketInstance() {
    return _instance;
  }

  static void init() {
    WebsocketInstance();
  }
}
