# config.py
import os

# 数据库配置
DB_CONFIG = {
    'host': os.getenv('DB_HOST', 'localhost'),
    'port': os.getenv('DB_PORT', '3306'),
    'user': os.getenv('DB_USER', 'root'),
    'password': os.getenv('DB_PASSWORD', 'shuang0209'),
    'database': os.getenv('DB_NAME', 'cpa_ad_management')
}

SQLALCHEMY_DATABASE_URI = f"mysql+pymysql://{DB_CONFIG['user']}:{DB_CONFIG['password']}@{DB_CONFIG['host']}:{DB_CONFIG['port']}/{DB_CONFIG['database']}?charset=utf8mb4"
SQLALCHEMY_TRACK_MODIFICATIONS = False

# 静态文件配置
STATIC_FOLDER = os.path.join(os.getcwd(), 'static')
UPLOAD_FOLDER = os.path.join(os.getcwd(), 'uploads')

# 会话密钥配置
SECRET_KEY = os.getenv('SECRET_KEY', 'your-secret-key-here')

# 快手 API 配置
KUAI_SHOU_API_CONFIG = {
    'base_url': os.getenv('KUAI_SHOU_API_BASE_URL', 'https://api.kuaishou.com'),
    'monitor_endpoint': os.getenv('KUAI_SHOU_API_MONITOR_ENDPOINT', '/monitor'),
    'callback_url': os.getenv('KUAI_SHOU_API_CALLBACK_URL', 'http://your_callback_url')
}

