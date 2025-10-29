import asyncio
import socket
import ipaddress
from aiogram import Bot, Dispatcher, types
from aiogram.filters import Command, CommandStart
from concurrent.futures import ThreadPoolExecutor

token = "ur token"
bot = Bot(token=token)
dp = Dispatcher()

executor = ThreadPoolExecutor(max_workers=10)
COMMON_PORTS = [21, 22, 23, 25, 53, 80, 110, 443, 993, 995, 8080, 8443]

async def check_port(host: str, port: int, timeout: float = 1.0) -> bool: 
    """Асинхронная проверка порта"""
    try: 
        loop = asyncio.get_event_loop()
        res = await loop.run_in_executor(
            executor, 
            lambda: check_port_sync(host, port, timeout)
        )
        return res
    except Exception:
        return False

def check_port_sync(host: str, port: int, timeout: float) -> bool:  # Исправлено: port: int
    try:
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
            sock.settimeout(timeout)
            result = sock.connect_ex((host, port))
            return result == 0
    except Exception:
        return False

async def scan_ports(host: str, ports: list) -> list:
    open_ports = [] 

    tasks = [check_port(host, port) for port in ports]
    results = await asyncio.gather(*tasks)

    # Исправлено: убрал лишний 'in ports'
    for port, is_open in zip(ports, results):
        if is_open:
            open_ports.append(port)
        
    return open_ports

@dp.message(CommandStart())
async def start_command(message: types.Message):
    await message.answer(
        "🔍 Nmap bot \n\n"
        "Доступные команды:\n"
        "/scan <ip/host> - Сканировать common порты\n"
        "/scan <ip/host> <port> - Проверить конкретный порт\n"
        "/scan <ip/host> <start_port>-<end_port> - Сканировать диапазон\n\n"
        "Примеры:\n"
        "/scan 192.168.1.1\n"
        "/scan google.com 80\n"
        "/scan 192.168.1.1 20-100"
    )

@dp.message(Command("scan"))
async def scan_command(message: types.Message):
    try:
        args = message.text.split()

        # Исправлено: неправильный вызов len()
        if len(args) < 2: 
            await message.answer("❌ Использование: /scan <host> [port/range]")  # Добавлено await
            return
        
        host = args[1]

        try: 
            ipaddress.ip_address(host)
        except ValueError:
            try:
                socket.gethostbyname(host)
            except socket.gaierror:
                await message.answer("❌ Неверный хост или домен")
                return
        
        status_msg = await message.answer(f"🔍 Сканирую {host}...")

        if len(args) == 2:
            ports_to_scan = COMMON_PORTS
            scan_type = "common порты"
        elif len(args) == 3:
            port_arg = args[2]
            
            if '-' in port_arg:
                try:
                    start_port, end_port = map(int, port_arg.split('-'))
                    if start_port < 1 or end_port > 65535 or start_port > end_port:
                        await message.answer("❌ Неверный диапазон портов (1-65535)")
                        return
                    ports_to_scan = list(range(start_port, end_port + 1))
                    scan_type = f"порты {start_port}-{end_port}"
                except ValueError:
                    await message.answer("❌ Неверный формат диапазона")
                    return
            else:
                try:
                    port = int(port_arg)
                    if port < 1 or port > 65535:
                        await message.answer("❌ Порт должен быть в диапазоне 1-65535")
                        return
                    ports_to_scan = [port]
                    scan_type = f"порт {port}"
                except ValueError:
                    await message.answer("❌ Порт должен быть числом")
                    return
        else:
            await message.answer("❌ Слишком много аргументов")
            return
        
        open_ports = await scan_ports(host, ports_to_scan)
        
        # Исправлено: правильные отступы
        if open_ports:
            result = f"✅ Открытые порты на {host} ({scan_type}):\n"
            for port in sorted(open_ports):
                # Убедимся что port это число
                port_num = port
                if not isinstance(port, int):
                    try:
                        port_num = int(port)
                    except:
                        port_num = port
                # Добавляем описание для известных портов
                service = get_service_name(port_num)
                result += f"🟢 Порт {port} - {service}\n"
        else:
            result = f"❌ На {host} нет открытых портов ({scan_type})"
        
        await status_msg.edit_text(result)  # Добавлено обновление сообщения
        
    except Exception as e:
        await message.answer(f"❌ Ошибка: {str(e)}")

def get_service_name(port: int) -> str:
    """Получить название сервиса для порта"""
    if not isinstance(port, int):
        try:
            port = int(port)
        except (ValueError, TypeError):
            return "Unknown"
    
    services = {
        21: "FTP", 22: "SSH", 23: "Telnet", 25: "SMTP", 53: "DNS",
        80: "HTTP", 110: "POP3", 443: "HTTPS", 993: "IMAPS", 995: "POP3S",
        8080: "HTTP-Alt", 8443: "HTTPS-Alt", 3306: "MySQL", 5432: "PostgreSQL", 27017: "MongoDB"
    }
    return services.get(port, "Unknown")

@dp.message(Command("ports"))
async def show_common_ports(message: types.Message):
    """Показать common порты"""
    ports_info = "📋 Common порты для сканирования:\n"
    for port in COMMON_PORTS:
        service = get_service_name(port)
        ports_info += f"• {port} - {service}\n"
    
    await message.answer(ports_info)

async def main():
    await dp.start_polling(bot)

if __name__ == "__main__":
    asyncio.run(main())
