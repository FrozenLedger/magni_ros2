# ros2_tcp_twist_sender.py (ROS2 Node)
import rclpy
from rclpy.node import Node
from geometry_msgs.msg import Twist
import socket
import json

class TwistSender(Node):
    def __init__(self):
        super().__init__('twist_sender')
        self.subscription = self.create_subscription(
            Twist,
            '/cmd_vel',
            self.listener_callback,
            10
        )
        self.sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        try:
            self.sock.connect(('ros1_container_ip', 5000))  # Set IP of ROS1 container
            self.get_logger().info('Connected to ROS1 bridge.')
        except Exception as e:
            self.get_logger().error(f'Connection failed: {e}')

    def listener_callback(self, msg):
        try:
            twist_dict = {
                'linear': {
                    'x': msg.linear.x,
                    'y': msg.linear.y,
                    'z': msg.linear.z
                },
                'angular': {
                    'x': msg.angular.x,
                    'y': msg.angular.y,
                    'z': msg.angular.z
                }
            }
            message = json.dumps(twist_dict).encode('utf-8')
            self.sock.sendall(message + b'\n')  # newline as delimiter
        except Exception as e:
            self.get_logger().error(f'Send failed: {e}')

def main(args=None):
    rclpy.init(args=args)
    node = TwistSender()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()
